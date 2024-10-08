//
//  RecapController.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

final class RecapController: ViewController {
  var onDismiss: VoidResult?
  var viewModel: RecapViewModelProtocol!

  override func closeButtonTapped(_ sender: AnyObject) {
    onDismiss?()
    dismiss(animated: true)
  }
}

// MARK: - Lifecycle

extension RecapController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()
  }
}

// MARK: - Setup

private extension RecapController {
  func setup() {
  }
}

// MARK: - Bindings

private extension RecapController {
  // NOTE: Reserve the Bindings extension for Combine/reactive stuff only

  func bind() {
  }
}

// MARK: - Actions

private extension RecapController {
//  @IBAction
//  func someButtonTapped(_ sender: Any) {
//    viewModel.someFunction2(
//      param1: 0,
//      param2: "",
//      onSuccess: handleSomeSuccess(),
//      onError: handleError()
//    )
//  }
}

// MARK: - Event Handlers

private extension RecapController {
//  func handleSomeSuccess() -> VoidResult {
//    return { [weak self] in
//      guard let self = self else { return }
//      // TODO: Do something here
//    }
//  }
}

// MARK: - Helpers

private extension RecapController {
}

// MARK: - SomeControllerProtocol

// extension RecapController: SomeControllerProtocol {
//
// }
