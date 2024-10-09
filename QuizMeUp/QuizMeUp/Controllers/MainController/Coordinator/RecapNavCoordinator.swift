//
//  RecapCoordinator.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

final class RecapNavCoordinator: Coordinator, TriggerableProtocol {
  var onDismiss: SingleResult<Coordinator>?
  private(set) var childCoordinator: [Coordinator] = []

  private let navRouter: UINavigationController
  private var nav: UINavigationController?

  private let screens: [Screen]
  private let index: Int

  init(
    navigationController: UINavigationController,
    screens: [Screen],
    index: Int
  ) {
    navRouter = navigationController
    self.screens = screens
    self.index = index
  }

  func start() {
    let vm = RecapViewModel(
      screens: screens,
      index: index
    )
    vm.coordinator = self
    let vc = R.storyboard.recap.recapController()!
    vc.onDismiss = didDismiss()
    vc.onNextScreen = trigger(type(of: self).pushNextScreen)
    vc.viewModel = vm

    let nav = UINavigationController(rootViewController: vc)
    nav.modalPresentationStyle = .fullScreen
    navRouter.present(nav, animated: true)
  }

  func didDismiss() -> VoidResult {
    return { [weak self] in
      guard let self else { return }
      guard let dismiss = onDismiss else {
        return
      }
      dismiss(self)
    }
  }
}

private extension RecapNavCoordinator {
  func pushNextScreen(nextIndex: Int) {
    guard screens.count >= nextIndex else {
      navRouter.dismiss(animated: true)
      return
    }
    loadScreen(screens: screens, index: nextIndex)
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
    let vm = RecapViewModel(
      screens: screens,
      index: index
    )
    let vc = R.storyboard.recap.recapController()!
    vc.onDismiss = didDismiss()
    vc.viewModel = vm
    nav?.pushViewController(vc, animated: true)
  }

  func loadMutipleChoiceScreen(
    screens: [Screen],
    index: Int
  ) {
    let vm = MultipleChoiceViewModel(
      screens: screens,
      index: index
    )
    let vc = R.storyboard.multipleChoice.multipleChoiceController()!
    vc.onDismiss = didDismiss()
    vc.onNextScreen = trigger(type(of: self).pushNextScreen)
    vc.viewModel = vm

    nav?.pushViewController(vc, animated: true)
  }
}
