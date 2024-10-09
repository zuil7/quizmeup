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
  var onTapStartButton: DoubleResult<[Screen], Int>?

  override var shouldHideNavBar: Bool { true }

  @IBOutlet private(set) var titleLabel: UILabel!
  @IBOutlet private(set) var quizDescriptionLabel: UILabel!
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
    populateData()
  }

  func loadJsonFile() {
    viewModel.loadQuiz(onSuccess: handleOnJsonLoadSuccess())
  }
}

// MARK: - Handler

extension MainController {
  func handleOnJsonLoadSuccess() -> VoidResult {
    return { [weak self] in
      guard let self else { return }
      self.populateData()
    }
  }
}

// MARK: - Helper

extension MainController {
  func populateData() {
    titleLabel.text = viewModel.title
    quizDescriptionLabel.text = viewModel.quizDescription
  }
}

// MARK: - Actions

private extension MainController {
  @IBAction
  func onStartButtonTapped(_ sender: Any) {
    onTapStartButton?(viewModel.screens, 0)
  }
}
