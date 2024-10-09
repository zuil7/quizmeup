//
//  Screen.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

enum ScreenType: String, Codable {
  case multipleChoiceModuleScreen
  case recapModuleScreen
}

// MARK: - Screen

struct Screen: Codable {
  let id: String
  let type: ScreenType
  let question: String?
  let multipleChoicesAllowed: Bool?
  var choices: [Choice]?
  let eyebrow: String?
  let body: String?
  var answers: [Answer]?
  let correctAnswer: String?
}
