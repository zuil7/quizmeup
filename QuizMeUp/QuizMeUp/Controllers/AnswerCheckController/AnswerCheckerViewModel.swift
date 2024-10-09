//
//  AnswerCheckerViewModel.swift
//  QuizMeUp
//
//  Created by Louise on 10/9/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

final class AnswerCheckerViewModel: AnswerCheckerViewModelProtocol {
  private let isAnswerCorrect: Bool

  init(
    isAnswerCorrect: Bool
  ) {
    self.isAnswerCorrect = isAnswerCorrect
  }
}


// MARK: - Getters

extension AnswerCheckerViewModel {
  var isCorrect: Bool { isAnswerCorrect }
}
