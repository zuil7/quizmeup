//
//  Welcome.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

// MARK: - Welcome

struct Welcome: Codable {
  let id: String
  let state: String
  let stateChangedAt: Date?
  let title: String
  let description: String
  let duration: String
  let activity: Activity
}
