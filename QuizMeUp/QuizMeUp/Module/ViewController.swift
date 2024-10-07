//
//  ViewController.swift
//  QuizMeUp
//
//  Created by Louise Namoc.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
}

extension ViewController {
  func showHud(message: String = "", color: UIColor = .white) {
    ProgressHud.shared.show(message: message, color: color)
  }

  func dismissHud() {
    ProgressHud.shared.dismiss()
  }
}
