//
//  AppCoordinator.swift
//  QuizMeUp
//
//  Created by Louise Nicolas Namoc on 8/12/21.
//  Copyright © 2021 Louise Nicolas Namoc. All rights reserved.
//

import UIKit

protocol Coordinator {
  var childCoordinator: [Coordinator] { get }
  func start()
}

final class AppCoordinator: Coordinator {
  private(set) var childCoordinator: [Coordinator] = []
  private let window: UIWindow
  init(window: UIWindow) {
    self.window = window
  }

  func start() {
    let nav = UINavigationController()
    let mainViewController = MainControllerCoordinator(navigationController: nav)
    childCoordinator.append(mainViewController)
    mainViewController.start()
    window.rootViewController = nav
    window.makeKeyAndVisible()
  }
}
