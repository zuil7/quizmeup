//
//  QuizServiceProtocol.swift
//  QuizMeUp
//
//  Created by Louise on 10/9/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol QuizServiceProtocol {
  func getQuiz(completion: @escaping ResultClosure<Welcome>)
}
