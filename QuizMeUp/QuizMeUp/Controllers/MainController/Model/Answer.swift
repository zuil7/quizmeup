//
//  Answer.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

// MARK: - Answer

struct Answer: Codable {
  let id: String
  let text: String
  var isSelected: Bool? = false
}

extension Array where Element == Answer {
  mutating func reset() {
    self = map { option in
      var modified = option
      modified.isSelected = false
      return modified
    }
  }

  mutating func setSelected(at index: Int) {
    guard index >= 0, index < count else {
      return
    }

    self[index].isSelected = !(self[index].isSelected ?? false)
  }

  func selectedAnswers() -> Answer? {
    return filter { $0.isSelected == true }.first ?? nil
  }
}
