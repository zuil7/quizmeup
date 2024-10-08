//
//  CallToAction.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol TriggerableProtocol: AnyObject {}

extension TriggerableProtocol {
  func trigger(_ callback: @escaping (Self) -> VoidResult) -> VoidResult {
    return { [weak self] in
      guard let self else { return }
      return callback(self)()
    }
  }

  func trigger<T>(_ callback: @escaping (Self) -> SingleResult<T>) -> SingleResult<T> {
    return { [weak self] result in
      guard let self else { return }
      return callback(self)(result)
    }
  }

  func trigger<T1, T2>(_ callback: @escaping (Self) -> DoubleResult<T1, T2>) -> DoubleResult<T1, T2> {
    return { [weak self] result1, result2 in
      guard let self else { return }
      return callback(self)(result1, result2)
    }
  }

  func trigger(_ keypath: KeyPath<Self, VoidResult?>) -> VoidResult {
    return { [weak self] in
      guard let self else { return }
      let callback = self[keyPath: keypath]
      callback?()
    }
  }

  func trigger<T>(_ keypath: KeyPath<Self, SingleResult<T>?>) -> SingleResult<T> {
    return { [weak self] result in
      guard let self else { return }
      let callback = self[keyPath: keypath]
      callback?(result)
    }
  }

  func trigger<T: AnyObject>(
    _ callback: @escaping (Self) -> SingleResult<T>,
    passingValue value: T
  ) -> VoidResult {
    return { [weak self, weak value] in
      guard
        let self,
        let value = value
      else { return }

      return callback(self)(value)
    }
  }

  func trigger<T>(
    _ callback: @escaping (Self) -> SingleResult<T>,
    passingValue value: T
  ) -> VoidResult {
    return { [weak self, value] in
      guard let self else { return }

      return callback(self)(value)
    }
  }
}

extension NSObject: TriggerableProtocol {}
