//
//  RecapViewModel.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

final class RecapViewModel: RecapViewModelProtocol {
  var refresh: VoidResult?
  var coordinator: RecapNavCoordinator?

  private var screens: [Screen]
  private var screen: Screen
  private var index: Int

  init(
    screens: [Screen],
    index: Int
  ) {
    self.screens = screens
    self.index = index
    screen = screens[index]
  }
}

// MARK: - Methods

extension RecapViewModel {
  func answerCellVM(at index: Int) -> AnswerCellViewModelProtocol? {
    guard let answer = screen.answers?[index] else {
      return nil
    }
    return AnswerCellViewModel(answer: answer)
  }

  func updateSelectedAnswer(at index: Int) {
    screen.answers?.reset()
    screen.answers?.setSelected(at: index)
    refresh?()
  }

  func resetAnswerSelection() {
    screen.answers?.reset()
    refresh?()
  }
}

// MARK: - Getters

extension RecapViewModel {
  var currentIndex: Int { index }
  var bodyText: String { screen.body ?? "" }
  var answerCount: Int { screen.answers?.count ?? 0 }
  var answers: [Answer] { screen.answers ?? [] }
  var nextIndex: Int { currentIndex + 1 }
  var quizTotal: Int { screens.count }

  var hasSelectedAnAnswer: Bool {
    let result = answers.filter {
      $0.isSelected ?? false
    }
    return result.count != 0
  }

  var isAnswerCorrect: Bool {
    let userAnswer = answers.selectedAnswers()
    return userAnswer?.id == screen.correctAnswer
  }

  var answerCheckerVM: AnswerCheckerViewModelProtocol { AnswerCheckerViewModel(isAnswerCorrect: isAnswerCorrect) }
}
