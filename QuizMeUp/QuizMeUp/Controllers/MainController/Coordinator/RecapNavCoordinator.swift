//
//  RecapCoordinator.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

final class RecapNavCoordinator: Coordinator {
  var onDismiss: SingleResult<Coordinator>?
  private(set) var childCoordinator: [Coordinator] = []

  private let navRouter: UINavigationController

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
