//
//  MainController.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

final class MainController: ViewController {
  var viewModel: MainViewModelProtocol!
  var onTapStartButton: VoidResult?
}

// MARK: - Lifecycle

extension MainController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

// MARK: - Setup

extension MainController {
  func setup() {
    loadJsonFile()
  }

  func loadJsonFile() {
    viewModel.loadQuiz()
  }
}

// MARK: - Actions

private extension MainController {
  @IBAction
  func onStartButtonTapped(_ sender: Any) {
  }
}
