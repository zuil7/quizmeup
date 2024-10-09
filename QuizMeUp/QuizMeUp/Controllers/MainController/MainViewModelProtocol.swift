//
//  MainAViewModelProtocol.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol {
  var title: String { get }
  var quizDescription: String { get }
  var screens: [Screen] { get }

  func loadQuiz(onSuccess: @escaping VoidResult)
  func fetchQuiz(completion: @escaping APIClientResultClosure)
}
