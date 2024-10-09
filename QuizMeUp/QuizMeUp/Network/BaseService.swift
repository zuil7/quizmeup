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

class BaseService {
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
          if let jsonString = String(data: data, encoding: .utf8) {
            let fixedJsonString = self.fixEncoding(jsonString)
            if let jsonData = fixedJsonString.data(using: .utf8) {
              let decoder = JSONDecoder()
              decoder.dateDecodingStrategy = .formatted(.iso8601Full)
              decoder.keyDecodingStrategy = .convertFromSnakeCase
              let statusCode = response.response?.statusCode
              if statusCode! >= 200 && statusCode! <= 299 {
                let value = try! decoder.decode(T.self, from: jsonData)
                completion?(value, nil)
              } else {
                let value = try! JSONDecoder().decode(T.self, from: jsonData)
                completion?(
                  value,
                  NSError.generic(
                    message: "Value is not \(String(describing: T.self))",
                    code: response.response?.statusCode
                  )
                )
              }
            }
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

extension BaseService {
  // Function to fix the encoding issues
  func fixEncoding(_ input: String) -> String {
    let fixed = input
      .replacingOccurrences(of: "â€™", with: "’") // Fix apostrophe
      .replacingOccurrences(of: "â€œ", with: "“") // Fix left double quote
      .replacingOccurrences(of: "â€", with: "”") // Fix right double quote
      .replacingOccurrences(of: "ðŸ¤¬", with: "😡") // Fix emoji
      .replacingOccurrences(of: "ðŸ˜ ", with: "😠") // Fix emoji
      .replacingOccurrences(of: "ðŸ˜’", with: "😒") // Fix emoji
      .replacingOccurrences(of: "ðŸ˜ˆ", with: "😏") // Fix emoji
      .replacingOccurrences(of: "ðŸ˜¤", with: "😤") // Fix emoji
      .replacingOccurrences(of: "âŒ", with: "🧘") // Fix emoji
      .replacingOccurrences(of: "ðŸ›‘", with: "🦁") // Fix emoji
      .replacingOccurrences(of: "ðŸ’ª", with: "💪") // Fix emoji
      .replacingOccurrences(of: "ðŸ‘‰", with: "👆") // Fix emoji
      .replacingOccurrences(of: "ðŸ”", with: "🔵") // Fix emoji
      .replacingOccurrences(of: "ðŸ”ƒ", with: "🔲") // Fix emoji
      .replacingOccurrences(of: "2ï¸âƒ£", with: "🔁") // Fix emoji
      .replacingOccurrences(of: "2ï¸âƒ£", with: "2️⃣🔄") // Fix emoji
      .replacingOccurrences(of: "ðŸ¤¯", with: "😤") // Fix emoji

    return fixed
  }
}
