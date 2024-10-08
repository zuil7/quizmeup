//
//  MainAViewModel.swift
//  QuizMeUp
//
//  Created by Louise on 10/7/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

final class MainViewModel: MainViewModelProtocol {
  private var welcome: Welcome?
}

// MARK: - Methods

extension MainViewModel {
  func loadQuiz(onSuccess: @escaping VoidResult) {
    if let data = loadJSONFromFile(filename: "Quiz"),
       let quiz = decodeJSON(from: data, as: Welcome.self) {
      welcome = quiz
      onSuccess()
    } else {
      print("Failed to load or decode JSON")
    }
  }
}

// MARK: - Private Method

private extension MainViewModel {
  func loadJSONFromFile(filename: String) -> Data? {
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "json") else {
      print("File not found")
      return nil
    }

    do {
      let data = try Data(contentsOf: fileURL)
      return data
    } catch {
      print("Error reading file:", error)
      return nil
    }
  }

  func decodeJSON<T: Codable>(from data: Data, as type: T.Type) -> T? {
    do {
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      print("Error decoding JSON:", error)
      return nil
    }
  }
}

// MARK: - Getter

extension MainViewModel {
  var title: String { welcome?.title ?? "" }
  var quizDescription: String {
    welcome?.description ?? ""
  }

  var screens: [Screen] {
    welcome?.activity.screens ?? []
  }
}
