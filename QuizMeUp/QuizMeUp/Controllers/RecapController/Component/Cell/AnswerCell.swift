//
//  AnswerCell.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

final class AnswerCell: UICollectionViewCell {
  var viewModel: AnswerCellViewModelProtocol! {
    didSet {
      refresh()
    }
  }

  @IBOutlet private(set) var textLabel: UILabel!
  @IBOutlet private(set) var containerView: UIView!
}

// MARK: - Refresh

private extension AnswerCell {
  func refresh() {
    guard viewModel != nil else { return }

    textLabel.text = viewModel.answerText
    textLabel.textColor = viewModel.isSelected ? .clear : .black
      let color = viewModel.isSelected ? R.color.gray_F0F0F0()! : UIColor.white
    containerView.backgroundColor = color
  }
}

// MARK: - Helpers

private extension AnswerCell {
}
