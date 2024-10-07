//
//  Screen.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

// MARK: - Screen

struct Screen: Codable {
  let id: String
  let type: String
  let question: String?
  let multipleChoicesAllowed: Bool?
  let choices: [Choice]?
  let eyebrow, body: String?
  let answers: [Answer]?
  let correctAnswer: String?
}
