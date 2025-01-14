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
    fetchQuiz()
//    loadJsonFile()
//    populateData()
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
  func fetchQuiz() {
    showHud()
    viewModel.fetchQuiz(completion: handleQuizSucces())
  }

  func populateData() {
    titleLabel.text = viewModel.title
    quizDescriptionLabel.text = viewModel.quizDescription
  }
}

// MARK: Event Handler

private extension MainController {
  func handleQuizSucces() -> APIClientResultClosure {
    return { [weak self] status, message in
      guard let self else { return }
      self.dismissHud()
      guard status else {
        self.showAlert(
          title: R.string.localizable.errorTitle(),
          message: message ?? R.string.localizable.errorGenericTitle()
        )
        return
      }
      self.populateData()
    }
  }
}

// MARK: - Actions

private extension MainController {
  @IBAction
  func onStartButtonTapped(_ sender: Any) {
    onTapStartButton?(viewModel.screens, 0)
  }
}
