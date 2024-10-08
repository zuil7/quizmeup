//
//  StepProgressView.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import PureLayout
import UIKit

@IBDesignable
class StepProgressView: UIView {
  // Indicates how many step
  @IBInspectable var totalSteps: Int = 4

  // Gap in between steps, 0 means no gaps
  @IBInspectable var gapWidth: CGFloat = 0

  private var stepper: UIStackView!

  // Indicates which step
  private var _onStep = 1
  @IBInspectable var onStep: Int {
    get {
      return _onStep
    }
    set {
      if newValue > totalSteps {
        _onStep = totalSteps
      } else if newValue < 1 {
        _onStep = 1
      } else {
        _onStep = newValue
      }
    }
  }

  private var borderWidthValue: CGFloat = 3
    private var primariesDefault: UIColor = R.color.purple_6442EF()!
  private var currentProgressColor: UIColor = .clear
  private var barBackgroundColor: UIColor = .darkGray

  override func awakeFromNib() {
    super.awakeFromNib()
    prepare()
  }

  func prepare() {
    backgroundColor = barBackgroundColor
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupIfNeeded()
  }
}

// MARK: - Setup

private extension StepProgressView {
  func setupIfNeeded() {
    guard stepper == nil else { return }

    layer.cornerRadius = cornerRadiusValue
    setupStepper()
    populateStepper()
  }

  func setupStepper() {
    let stepper = UIStackView()
    stepper.axis = .horizontal
    stepper.spacing = gapWidth
    stepper.distribution = .fillEqually

    let stepperContainerView = UIView()
    stepperContainerView.backgroundColor = primariesDefault
    addSubview(stepperContainerView)
    stepperContainerView.autoSetDimension(.width, toSize: stepperWidth)
    stepperContainerView.autoPinEdge(toSuperviewEdge: .leading)
    stepperContainerView.autoPinEdge(toSuperviewEdge: .top)
    stepperContainerView.autoPinEdge(toSuperviewEdge: .bottom)

    stepperContainerView.addSubview(stepper)
    stepper.autoPinEdgesToSuperviewEdges()

    addSubview(stepperContainerView)

    self.stepper = stepper
  }

  func populateStepper() {
    (1 ... onStep)
      .map(generatePillView(at:))
      .forEach(stepper.addArrangedSubview)
  }

  func generatePillView(at index: Int) -> UIView {
    let pillContainerView = UIView()
    pillContainerView.backgroundColor = barBackgroundColor

    let edgeBlockerStackView = UIStackView()
    edgeBlockerStackView.axis = .horizontal
    edgeBlockerStackView.distribution = .fillEqually

    let leftView = UIView()
    leftView.backgroundColor = primariesDefault
    edgeBlockerStackView.addArrangedSubview(leftView)

    let rightView = UIView()
    rightView.backgroundColor = primariesDefault
    edgeBlockerStackView.addArrangedSubview(rightView)

    pillContainerView.addSubview(edgeBlockerStackView)
    edgeBlockerStackView.autoPinEdgesToSuperviewEdges()

    let pill = UIView()
    pill.backgroundColor = primariesDefault
    pill.layer.cornerRadius = cornerRadiusValue
    pillContainerView.addSubview(pill)
    pill.autoPinEdgesToSuperviewEdges()

    pillContainerView.sendSubviewToBack(edgeBlockerStackView)

    if index == 1 {
      leftView.backgroundColor = barBackgroundColor
    }

    if index == onStep {
      rightView.backgroundColor = currentProgressColor
    }

    if hasGap {
      leftView.backgroundColor = barBackgroundColor
    }

    return pillContainerView
  }
}

// MARK: - Private Getters

private extension StepProgressView {
  var hasGap: Bool { gapWidth > 0 }
  var cornerRadiusValue: CGFloat { frame.size.height / 2 }
  var progress: CGFloat { CGFloat(onStep) / CGFloat(totalSteps) }
  var stepperWidth: CGFloat { frame.size.width * progress }
}
