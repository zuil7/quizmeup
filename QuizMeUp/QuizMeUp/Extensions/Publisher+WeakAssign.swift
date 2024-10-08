//
//  Publisher+WeakAssign.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Combine
import Foundation

extension Publisher where Failure == Never {
  func weakAssign<T: AnyObject>(
    to keyPath: ReferenceWritableKeyPath<T, Output>,
    on object: T
  ) -> AnyCancellable {
    sink { [weak object] value in
      object?[keyPath: keyPath] = value
    }
  }
}
