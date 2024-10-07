//
//  NSError+Extension.swift
//  QuizMeUp
//
//  Created by Louise Nicolas Namoc on 8/12/21.
//  Copyright © 2021 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

extension NSError {
  static func generic(message: String, code: Int? = -1) -> NSError {
    return NSError(domain: "Error", code: code!, userInfo: ["message": message])
  }
}
