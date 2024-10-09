//
//  ViewController.swift
//  QuizMeUp
//
//  Created by Louise Namoc.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var shouldHideNavBar: Bool { false }
  var shouldShowProgressBar: Bool { false }

  var progressView: StepProgressView = {
    let progress = StepProgressView()
    progress.backgroundColor = .lightGray
    progress.layer.cornerRadius = 8
    return progress
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavBarItems()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavBar(animated)

    if shouldShowProgressBar {
      setupNavigationBarProgressBar()
    }
  }
}

extension ViewController {
  func setupNavBar(_ animated: Bool) {
    guard
      let nc = navigationController,
      !shouldHideNavBar
    else {
      navigationController?.setNavigationBarHidden(
        true,
        animated: animated
      )
      return
    }

    nc.setNavigationBarHidden(false, animated: animated)
  }

  func setupNavBarItems() {
    navigationController?.interactivePopGestureRecognizer?.delegate = self

    if navigationController?.viewControllers.first != self {
      let backButton = UIBarButtonItem(
        image: R.image.back(),
        style: .plain,
        target: self,
        action: #selector(backButtonTapped(_:))
      )

      navigationItem.leftBarButtonItem = backButton
      backButton.tintColor = R.color.gray_A2A2A2()!
    }
    let closeButton = UIBarButtonItem(
      image: R.image.close(),
      style: .plain,
      target: self,
      action: #selector(closeButtonTapped(_:))
    )

    navigationItem.rightBarButtonItem = closeButton
    closeButton.tintColor = R.color.gray_A2A2A2()!
  }

  func setupNavigationBarProgressBar() {
    // Check if the navigation controller and its navigation bar are available
    guard let navigationBar = navigationController?.navigationBar else { return }

    // Add the progress bar to the navigation bar
    navigationBar.addSubview(progressView)

    progressView.autoPinEdge(toSuperviewEdge: .top)
    progressView.autoPinEdge(.left, to: .left, of: navigationBar, withOffset: 16.0)
    progressView.autoPinEdge(.right, to: .right, of: navigationBar, withOffset: -16.0)
    progressView.autoSetDimension(.height, toSize: 4)
  }

  @IBAction
  func backButtonTapped(_ sender: AnyObject) {
    navigationController?.popViewController(animated: true)
  }

  @IBAction
  func closeButtonTapped(_ sender: AnyObject) {
    dismiss(animated: true, completion: nil)
  }
}

extension ViewController {
  func showHud(message: String = "", color: UIColor = .white) {
    ProgressHud.shared.show(message: message, color: color)
  }

  func dismissHud() {
    ProgressHud.shared.dismiss()
  }

  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "Ok", style: .default) { _ in }
    alertController.addAction(ok)
    present(alertController, animated: true, completion: nil)
  }

  // MARK: - Delay

  func delay(_ seconds: Double, task: @escaping VoidResult) {
    let when = DispatchTime.now() + seconds
    DispatchQueue.main.asyncAfter(deadline: when, execute: task)
  }
}

extension ViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return true
  }
}
