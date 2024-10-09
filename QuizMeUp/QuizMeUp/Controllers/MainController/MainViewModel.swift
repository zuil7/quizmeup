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
  private var quizService: QuizServiceProtocol

  init(quizService: QuizServiceProtocol) {
    self.quizService = quizService
  }
}

// MARK: - Methods

extension MainViewModel {
  func fetchQuiz(
    completion: @escaping APIClientResultClosure) {
    quizService.getQuiz { [weak self] welcome, status, message in
      guard let self, status else { return completion(false, message) }
      self.welcome = welcome
      completion(true, nil)
    }
  }

  func loadQuiz(onSuccess: @escaping VoidResult) {
    if let welcome: Welcome = loadJSONFromFile(
      filename: "Quiz",
      ofType: Welcome.self
    ) {
      self.welcome = welcome
      onSuccess()
    } else {
      print("Failed to load or decode the Welcome object.")
    }
  }

  // Function to fix the encoding issues
  func fixEncoding(_ input: String) -> String {
    let fixed = input
      .replacingOccurrences(of: "â€™", with: "’") // Fix apostrophe
      .replacingOccurrences(of: "â€œ", with: "“") // Fix left double quote
      .replacingOccurrences(of: "â€", with: "”") // Fix right double quote
      .replacingOccurrences(of: "ðŸ¤¬", with: "😡") // Fix emoji
      .replacingOccurrences(of: "ðŸ˜ ", with: "😠") // Fix emoji
      .replacingOccurrences(of: "ðŸ˜’", with: "😒") // Fix emoji
      .replacingOccurrences(of: "ðŸ˜ˆ", with: "😏") // Fix emoji
      .replacingOccurrences(of: "ðŸ˜¤", with: "😤") // Fix emoji
      .replacingOccurrences(of: "âŒ", with: "🧘") // Fix emoji
      .replacingOccurrences(of: "ðŸ›‘", with: "🦁") // Fix emoji
      .replacingOccurrences(of: "ðŸ’ª", with: "💪") // Fix emoji
      .replacingOccurrences(of: "ðŸ‘‰", with: "👆") // Fix emoji
      .replacingOccurrences(of: "ðŸ”", with: "🔵") // Fix emoji
      .replacingOccurrences(of: "ðŸ”ƒ", with: "🔲") // Fix emoji
      .replacingOccurrences(of: "2ï¸âƒ£", with: "🔁") // Fix emoji
      .replacingOccurrences(of: "2ï¸âƒ£", with: "2️⃣🔄") // Fix emoji
      .replacingOccurrences(of: "ðŸ¤¯", with: "😤") // Fix emoji

    return fixed
  }
}

// MARK: - Private Method

private extension MainViewModel {
  func loadJSONFromFile<T: Decodable>(
    filename: String,
    ofType type: T.Type
  ) -> T? {
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "json") else {
      print("File not found")
      return nil
    }

    do {
      let data = try Data(contentsOf: fileURL)
      if let jsonString = String(data: data, encoding: .utf8) {
        let fixedJsonString = fixEncoding(jsonString)
        if let jsonData = fixedJsonString.data(using: .utf8) {
          // Decode the JSON
          do {
            let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedObject
          } catch {
            print("Error decoding JSON: \(error)")
          }
        }
      } else {
        print("Failed to convert data to string.")
      }
    } catch {
      print("Error reading file:", error)
    }

    return nil
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
