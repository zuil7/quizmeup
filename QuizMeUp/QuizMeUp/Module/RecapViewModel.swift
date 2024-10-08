//
//  RecapViewModel.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

final class RecapViewModel: RecapViewModelProtocol {
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

}

// MARK: - Getters

extension RecapViewModel {
}
