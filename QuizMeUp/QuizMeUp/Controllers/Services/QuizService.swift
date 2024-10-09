//
//  QuizService.swift
//  QuizMeUp
//
//  Created by Louise on 10/9/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

final class QuizService: BaseService, QuizServiceProtocol {
  func getQuiz(completion: @escaping ResultClosure<Welcome>) {
    consumeAPI(
      Welcome.self,
      endPoint: quizUrlEndPoint,
      verb: .GET
    ) { result, error in
      guard error == nil else {
        return completion(nil, false, error?.localizedDescription)
      }
      completion(result, true, nil)
    }
  }
}

// MARK: - Methods

extension QuizService {
//  func fetchSomeObjects(
//    onSuccess: @escaping SingleResult<[SomeModel]>,
//    onError: @escaping ErrorResult
//  ) -> RequestProtocol? {
//    api.getSomeObjects(
//      param: param,
//      onSuccess: onSuccess,
//      onError: onError
//    )
//  }
//
//  func submitSomething(
//    param: Int,
//    onSuccess: @escaping VoidResult,
//    onError: @escaping ErrorResult
//  ) -> RequestProtocol?
}
