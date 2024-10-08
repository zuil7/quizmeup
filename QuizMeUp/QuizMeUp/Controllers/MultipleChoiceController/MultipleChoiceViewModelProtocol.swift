//
//  MultipleChoiceViewModelProtocol.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol MultipleChoiceViewModelProtocol {
  var refresh: VoidResult? { get set }
  var onNextScreen: VoidResult? { get set }

  var currentIndex: Int { get }
  var nextIndex: Int { get }

  var quizTotal: Int { get }
  var isMultipleChoice: Bool { get }

  var questionText: String { get }
  var choices: [Choice] { get }

  func updateChoice(at index: Int)
}
