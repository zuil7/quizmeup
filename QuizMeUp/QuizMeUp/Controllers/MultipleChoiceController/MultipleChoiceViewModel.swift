//
//  MultipleChoiceViewModel.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Combine
import Foundation

final class MultipleChoiceViewModel: MultipleChoiceViewModelProtocol {
  var refresh: VoidResult?
  var onNextScreen: VoidResult?

  var coordinator: MultipleChoiceNavCoordinator?

  private var screens: [Screen]
  @Published private var choicesList: [Choice]

  private var screen: Screen
  private var index: Int

  init(
    screens: [Screen],
    index: Int
  ) {
    self.screens = screens
    self.index = index
    screen = screens[index]
    choicesList = screens[index].choices ?? []
  }
}

// MARK: - Methods

extension MultipleChoiceViewModel {
  func updateChoice(at index: Int) {
    if isMultipleChoice {
      choicesList[index].isSelected = !(choicesList[index].isSelected ?? false)

      refresh?()
    } else {
      choicesList[index].isSelected = !(choicesList[index].isSelected ?? false)
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
  var choices: [Choice] { choicesList }
  var nextIndex: Int { currentIndex + 1 }
  var canSubmit: AnyPublisher<Bool, Never> {
    $choicesList
      .map { options in
          options.contains(where: { $0.isSelected ?? false })
      }
      .eraseToAnyPublisher()
  }
}
