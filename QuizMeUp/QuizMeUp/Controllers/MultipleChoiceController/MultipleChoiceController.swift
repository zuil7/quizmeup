//
//  MultipleChoiceController.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Combine
import Foundation
import PureLayout
import UIKit

final class MultipleChoiceController: ViewController {
  var onDismiss: VoidResult?
  var onNextScreen: SingleResult<Int>?

  var viewModel: MultipleChoiceViewModelProtocol!

  @IBOutlet private(set) var questionLabel: UILabel!
  @IBOutlet private(set) var choicesStackView: UIStackView!
  @IBOutlet private(set) var continueButton: UIButton!
  @IBOutlet private(set) var selectAllApplyLabel: UILabel!

  private var anyCancellables = Set<AnyCancellable>()

  override var shouldShowProgressBar: Bool { true }

  override func closeButtonTapped(_ sender: AnyObject) {
    onDismiss?()
    dismiss(animated: true)
  }
}

// MARK: - Lifecycle

extension MultipleChoiceController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()
  }
}

// MARK: - Setup

private extension MultipleChoiceController {
  func setup() {
    setupProgressView()
    loadQuestion()
    setupContinueButton()
    setupChoicesStackView()
  }

  func setupProgressView() {
    progressView.totalSteps = viewModel.quizTotal
    progressView.onStep = viewModel.currentIndex
  }

  func setupContinueButton() {
    continueButton.isHidden = !viewModel.isMultipleChoice
  }

  func setupChoicesStackView() {
    for subview in choicesStackView.arrangedSubviews {
      subview.removeFromSuperview()
    }

    viewModel.choices
      .enumerated()
      .map { createChoicesView(index: $0.offset, choice: $0.element) }
      .forEach(choicesStackView.addArrangedSubview)
  }

  func loadQuestion() {
    questionLabel.text = viewModel.questionText
    selectAllApplyLabel.isHidden = !viewModel.isMultipleChoice
  }
}

// MARK: - Bindings

private extension MultipleChoiceController {
  func bind() {
    viewModel.refresh = trigger(type(of: self).setupChoicesStackView)
    viewModel.onNextScreen = trigger(type(of: self).handleOnNexScreen)
    bindButton()
  }

  func bindButton() {
    viewModel.canSubmit
      .receive(on: DispatchQueue.main)
      .sink { [weak self] canSubmit in
        guard let self else { return }
        self.continueButton.isEnabled = canSubmit
        let color = canSubmit ? R.color.purple_6442EF()! : R.color.purpleDisable_DDD5FB()!
        self.continueButton.backgroundColor = color
      }
      .store(in: &anyCancellables)
  }
}

// MARK: - Actions

private extension MultipleChoiceController {
  @IBAction
  func continueButtonTapped(_ sender: Any) {
    onNextScreen?(viewModel.nextIndex)
  }

  // Define the tap handler function
  @objc
  func handleTap(_ sender: UITapGestureRecognizer) {
    if let tappedView = sender.view {
      viewModel.updateChoice(at: tappedView.tag)
    }
  }
}

// MARK: - Event Handlers

private extension MultipleChoiceController {
  func handleOnNexScreen() {
    onNextScreen?(viewModel.nextIndex)
  }
}

// MARK: - Helpers

private extension MultipleChoiceController {
  func createChoicesView(index: Int, choice: Choice) -> UIView {
    let view = UIView()
    view.tag = index
    view.layer.cornerRadius = 12
    view.layer.borderWidth = 1

    let borderColor = (choice.isSelected ?? false) ? R.color.purple_6442EF()!.cgColor : UIColor.lightGray.cgColor
    view.layer.borderColor = borderColor

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    view.addGestureRecognizer(tapGesture)
    view.isUserInteractionEnabled = true

    let iconLabel = UILabel()
    iconLabel.text = choice.emoji
    view.addSubview(iconLabel)

    iconLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
    iconLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
    iconLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12)
    iconLabel.autoSetDimension(.width, toSize: 24)

    let choiceLabel = UILabel()
    choiceLabel.text = choice.text
    choiceLabel.textColor = .black
    choiceLabel.numberOfLines = 0
    view.addSubview(choiceLabel)

    choiceLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
    choiceLabel.autoPinEdge(.left, to: .right, of: iconLabel, withOffset: 12)
    choiceLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12)
    choiceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)

    return view
  }
}
