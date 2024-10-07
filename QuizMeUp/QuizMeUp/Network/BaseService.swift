//
//  BaseService.swift
//  QuizMeUp
//
//  Created by Louise Nicolas Namoc on 8/12/21.
//  Copyright © 2021 Louise Nicolas Namoc. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyUserDefaults

final class BaseService {
  func consumeAPI<T: Decodable>(
    _ decodeType: T.Type,
    endPoint url: String,
    verb restVerb: RestVerbs,
    parameters params: Parameters? = nil,
    customHeader: HTTPHeaders? = nil,
    completion: OnCompletionHandle<T>? = nil
  ) {
    var httpHeader: HTTPHeaders?
    if let validToken = Defaults[\.token], !validToken.isEmpty {
      httpHeader = ["token": "\(validToken)"]
    }

    if let header = customHeader {
      httpHeader = header
    }

    let localVerb = getVerb(type: restVerb)
    AF.request(
      url,
      method: localVerb,
      parameters: params,
      encoding: JSONEncoding.default,
      headers: httpHeader
    ).responseJSON { response in

      switch response.result {
      case .success:
        if let data = response.data {
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .formatted(.iso8601Full)
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          let statusCode = response.response?.statusCode
          if statusCode! >= 200 && statusCode! <= 299 {
            let value = try! decoder.decode(T.self, from: data)
            completion?(value, nil)
          } else {
            let value = try! JSONDecoder().decode(T.self, from: data)
            completion?(
              value,
              NSError.generic(
                message: "Value is not \(String(describing: T.self))",
                code: response.response?.statusCode
              )
            )
          }
        } else {
          completion?(
            nil,
            NSError.generic(message: "Value is not \(String(describing: T.self))", code: -1)
          )
        }
      case let .failure(error):
        completion?(nil, error as NSError)
      }
    }
  }

  private func getVerb(type: RestVerbs) -> HTTPMethod {
    var localVerb: HTTPMethod!
    switch type {
    case .POST:
      localVerb = .post
    case .GET:
      localVerb = .get
    case .PUT:
      localVerb = .put
    case .DELETE:
      localVerb = .delete
    case .PATCH:
      localVerb = .patch
    }
    return localVerb
  }
}
