//
//  AnswerCheckerController.swift
//  QuizMeUp
//
//  Created by Louise on 10/9/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import SwiftyGif
import UIKit

final class AnswerCheckerController: ViewController {
  var onCheckBackAnswer: VoidResult?
  var viewModel: AnswerCheckerViewModelProtocol!

  @IBOutlet private(set) var answerStatusLabel: UILabel!
  @IBOutlet private(set) var barView: UIView!
  @IBOutlet private(set) var gifImageView: UIImageView!

  override var shouldHideNavBar: Bool { true }
}

// MARK: - Lifecycle

extension AnswerCheckerController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }
}

// MARK: - Setup

private extension AnswerCheckerController {
  func setup() {
    view.backgroundColor = .clear
    populateResult()
  }

  func populateResult() {
    if viewModel.isCorrect {
      if let gif = try? UIImage(gifName: "confetti.gif") {
        gifImageView.setGifImage(gif, loopCount: 1) 
      }
    }
    let barBgColor = viewModel.isCorrect ? R.color.green_3AB27D()! : R.color.red_FC3021()!
    barView.backgroundColor = barBgColor

    let status = viewModel.isCorrect ? R.string.localizable.correctAnswer() : R.string.localizable.wrongAnswer()
    answerStatusLabel.text = status
  }
}

// MARK: - Actions

private extension AnswerCheckerController {
  @IBAction
  func continueButtonTapped(_ sender: Any) {
    dismiss(animated: false, completion: { [weak self] in
      guard let self else { return }
      self.onCheckBackAnswer?()
    })
  }
}

// MARK: - Helpers

private extension AnswerCheckerController {
}
