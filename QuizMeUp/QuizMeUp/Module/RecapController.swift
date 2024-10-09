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
  var onNextScreen: SingleResult<Int>?
  var viewModel: RecapViewModelProtocol!

  private let fontSize: CGFloat = 22
  @IBOutlet private(set) var questionLabel: UILabel!
  @IBOutlet private(set) var checkButton: UIButton!
  @IBOutlet private(set) var collectionView: DynmicHeightCollectionView!

  private var recapContainerView: UIView?
  override var shouldShowProgressBar: Bool { true }

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
    setupProgressView()
    setupQuestionLabel()
    setupCollectionView()
  }

  func setupProgressView() {
    progressView.totalSteps = viewModel.quizTotal
    progressView.onStep = viewModel.currentIndex
  }

  func setupCollectionView() {
    let layout = DynamicFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    layout.scrollDirection = .vertical

    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .clear
    collectionView.register(R.nib.answerCell)
  }

  func setupQuestionLabel() {
    let paragraphFont = UIFont.systemFont(ofSize: fontSize)

    let recapView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: paragraphFont.lineHeight))
    recapView.backgroundColor = .clear
    recapView.layer.cornerRadius = 4
    recapView.clipsToBounds = true

    let label = UILabel(frame: recapView.bounds)
    label.text = "________"
    label.textAlignment = .center
    label.font = paragraphFont
    label.textColor = R.color.gray_A2A2A2()!
    label.backgroundColor = .clear

    createRecapQuestionLabel(
      recapView: recapView,
      recapLabel: label
    )
  }

  func createRecapQuestionLabel(
    recapView: UIView,
    recapLabel: UILabel
  ) {
    let splitText = viewModel.bodyText.components(separatedBy: "%  RECAP  %")

    let attributedString = NSMutableAttributedString()

    let paragraphFont = UIFont.systemFont(ofSize: fontSize)

    if splitText.count == 2 {
      let firstPart = NSAttributedString(string: splitText[0], attributes: [NSAttributedString.Key.font: paragraphFont])
      attributedString.append(firstPart)

      recapView.addSubview(recapLabel)

      UIGraphicsBeginImageContextWithOptions(recapView.bounds.size, false, 0.0)
      recapView.layer.render(in: UIGraphicsGetCurrentContext()!)
      let recapImage = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()

      let attachment = NSTextAttachment()
      attachment.image = recapImage

      let attachmentHeight = paragraphFont.lineHeight
      let imageRatio = recapImage.size.width / recapImage.size.height
      attachment.bounds = CGRect(x: 0, y: (paragraphFont.descender) / 2, width: attachmentHeight * imageRatio, height: attachmentHeight)

      let attachmentString = NSAttributedString(attachment: attachment)

      attributedString.append(attachmentString)

      let secondPart = NSAttributedString(string: splitText[1], attributes: [NSAttributedString.Key.font: paragraphFont])
      attributedString.append(secondPart)
    } else {
      let fallbackText = NSAttributedString(string: viewModel.bodyText, attributes: [NSAttributedString.Key.font: paragraphFont])
      attributedString.append(fallbackText)
    }

    questionLabel.attributedText = attributedString
    questionLabel.font = UIFont.systemFont(ofSize: fontSize)
  }
}

// MARK: - Bindings

private extension RecapController {
  func bind() {
    viewModel.refresh = trigger(type(of: self).refresh)
  }
}

// MARK: - Actions

private extension RecapController {
  @IBAction
  func checkButtonTapped(_ sender: Any) {
    showChecker()
  }

  func getLabelWidth(
    for text: String,
    with font: UIFont,
    padding: UIEdgeInsets
  ) -> CGFloat {
    let attributes: [NSAttributedString.Key: Any] = [.font: font]

    // Calculate the size of the text
    let textWidth = (text as NSString).boundingRect(
      with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
      options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine],
      attributes: attributes,
      context: nil
    ).width

    // Add padding
    let totalWidth = textWidth + padding.left + padding.right

    return totalWidth
  }
}

// MARK: - Event Handlers

private extension RecapController {
  func handleCheckBackAnswer() {
    if viewModel.isAnswerCorrect {
      onNextScreen?(viewModel.nextIndex)
    } else {
      setupQuestionLabel()
      viewModel.resetAnswerSelection()
    }
  }
}

// MARK: - Helpers

private extension RecapController {
  func refresh() {
    checkButton.isHidden = !viewModel.hasSelectedAnAnswer
    collectionView.reloadData()
    collectionView.layoutIfNeeded()
  }

  func showChecker() {
    let vc = R.storyboard.answerChecker.answerCheckerController()!
    vc.viewModel = viewModel.answerCheckerVM
    vc.onCheckBackAnswer = trigger(type(of: self).handleCheckBackAnswer)

    let nav = UINavigationController(rootViewController: vc)
    nav.modalPresentationStyle = .overCurrentContext
    navigationController?.present(nav, animated: true)
  }

  func populateAnswer(at index: Int) {
    questionLabel.attributedText = nil
    let answer = viewModel.answers[index].text
    let paragraphFont = UIFont.systemFont(ofSize: fontSize)
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    let width = getLabelWidth(
      for: answer,
      with: paragraphFont,
      padding: padding
    )
    let recapView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: paragraphFont.lineHeight))
    recapView.backgroundColor = .clear
    recapView.layer.cornerRadius = 4
    recapView.clipsToBounds = true
    recapView.layer.borderWidth = 1
    recapView.layer.borderColor = R.color.gray_212121_20()!.cgColor
    recapView.layer.cornerRadius = 8

    let label = UILabel(frame: recapView.bounds)
    label.numberOfLines = 0
    label.text = answer
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: fontSize)
    label.textColor = .black
    label.backgroundColor = .clear

    createRecapQuestionLabel(
      recapView: recapView,
      recapLabel: label
    )
  }
}

extension RecapController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.answerCount
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: R.reuseIdentifier.answerCell,
      for: indexPath
    ) else {
      return UICollectionViewCell()
    }

    cell.viewModel = viewModel.answerCellVM(at: indexPath.row)
    return cell
  }

  // Delegate Methods
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.updateSelectedAnswer(at: indexPath.row)
    populateAnswer(at: indexPath.row)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let text = viewModel.answers[indexPath.item].text

    let cellWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16.0)]).width + 30.0

    return CGSize(width: cellWidth, height: 30.0)
  }
}
