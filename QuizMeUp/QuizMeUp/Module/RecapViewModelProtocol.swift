//
//  RecapViewModelProtocol.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol RecapViewModelProtocol {
  var refresh: VoidResult? { get set }

  var hasSelectedAnAnswer: Bool { get }
  var answerCount: Int { get }
  var bodyText: String { get }
  var answers: [Answer] { get }
  var isAnswerCorrect: Bool { get }
  var answerCheckerVM: AnswerCheckerViewModelProtocol { get }
  var nextIndex: Int { get }
  var currentIndex: Int { get }
  var quizTotal: Int { get }

  func updateSelectedAnswer(at index: Int)
  func resetAnswerSelection()

  func answerCellVM(at index: Int) -> AnswerCellViewModelProtocol?
}
