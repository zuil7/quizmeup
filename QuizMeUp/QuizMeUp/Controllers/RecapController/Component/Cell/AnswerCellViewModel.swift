//
//  AnswerCellViewModel.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

final class AnswerCellViewModel: AnswerCellViewModelProtocol {
  private let answer: Answer

  init(
    answer: Answer
  ) {
    self.answer = answer
  }
}

// MARK: - Getters

extension AnswerCellViewModel {
  var answerText: String { answer.text }
  var isSelected: Bool { answer.isSelected ?? false }
}
