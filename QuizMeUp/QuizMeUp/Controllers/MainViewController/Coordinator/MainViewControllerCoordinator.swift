//
//  MainViewControllerCoordinator.swift
//  QuizMeUp
//
//  Created by Louise Nicolas Namoc on 8/12/21.
//  Copyright © 2021 Louise Nicolas Namoc. All rights reserved.
//

import UIKit

final class MainViewControllerCoordinator: Coordinator {
  private(set) var childCoordinator: [Coordinator] = []

  private let nav: UINavigationController
    
  init(navigationController: UINavigationController) {
    nav = navigationController
  }

  func start() {
    let vc = R.storyboard.main.mainViewController()!
    nav.setViewControllers([vc], animated: false)
  }
}
