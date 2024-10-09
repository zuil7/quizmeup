//
//  MainControllerCoordinator.swift
//  QuizMeUp
//
//  Created by Louise Nicolas Namoc on 8/12/21.
//  Copyright © 2021 Louise Nicolas Namoc. All rights reserved.
//

import UIKit

final class MainControllerCoordinator: Coordinator {
  private(set) var childCoordinator: [Coordinator] = []

  private let nav: UINavigationController

  init(navigationController: UINavigationController) {
    nav = navigationController
  }

  func start() {
    let vm = MainViewModel(quizService: QuizService())
    let vc = R.storyboard.main.mainController()!
    vc.onTapStartButton = handleStartButtonTapped()

    vc.viewModel = vm
    nav.setViewControllers([vc], animated: false)
  }

  func handleStartButtonTapped() -> DoubleResult<[Screen], Int> {
    return { [weak self] screens, index in
      guard let self else { return }
      self.loadScreen(screens: screens, index: index)
    }
  }

  func loadScreen(screens: [Screen], index: Int) {
    let screen = screens[index]

    switch screen.type {
    case .recapModuleScreen:
      loadRecapScene(screens: screens, index: index)
    case .multipleChoiceModuleScreen:
      loadMutipleChoiceScreen(screens: screens, index: index)
    }
  }

  func loadRecapScene(
    screens: [Screen],
    index: Int
  ) {
    let recapCoordinator = RecapNavCoordinator(
      navigationController: nav,
      screens: screens,
      index: index
    )
    recapCoordinator.onDismiss = childDidFinish()
    childCoordinator.append(recapCoordinator)
    recapCoordinator.start()
  }

  func loadMutipleChoiceScreen(
    screens: [Screen],
    index: Int
  ) {
    let multipleChoiceNavCoordinator = MultipleChoiceNavCoordinator(
      navigationController: nav,
      screens: screens,
      index: index
    )
    multipleChoiceNavCoordinator.onDismiss = childDidFinish()
    childCoordinator.append(multipleChoiceNavCoordinator)
    multipleChoiceNavCoordinator.start()
  }

  func childDidFinish() -> SingleResult<Coordinator>? {
    return { [weak self] childCoordinator in
      guard let self = self else { return }
      if let index = self.childCoordinator.firstIndex(where: { coordinator -> Bool in
        childCoordinator === coordinator
      }) {
        self.childCoordinator.remove(at: index)
      }
    }
  }
}
