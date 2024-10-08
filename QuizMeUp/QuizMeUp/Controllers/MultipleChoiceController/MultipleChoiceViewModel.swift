//
//  MultipleChoiceViewModel.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

final class MultipleChoiceViewModel: MultipleChoiceViewModelProtocol {
  var refresh: VoidResult?
  var onNextScreen: VoidResult?

  var coordinator: MultipleChoiceNavCoordinator?

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

extension MultipleChoiceViewModel {
  func updateChoice(at index: Int) {
    if isMultipleChoice {
      if var choice = screen.choices {
        choice[index].isSelected = !(choice[index].isSelected ?? false)
        screen.choices?[index] = choice[index]
      }

      refresh?()
    } else {
      if var choice = screen.choices {
        choice[index].isSelected = !(choice[index].isSelected ?? false)
        screen.choices?[index] = choice[index]
      }
      onNextScreen?()
    }
  }
}

// MARK: - Getters

extension MultipleChoiceViewModel {
  var currentIndex: Int { index }
  var quizTotal: Int { screens.count }
  var isMultipleChoice: Bool { screen.multipleChoicesAllowed ?? false }
  var questionText: String { screen.question ?? "" }
  var choices: [Choice] { screen.choices ?? [] }
  var nextIndex: Int { currentIndex + 1 }
}
