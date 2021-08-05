//
//  StringExtension.swift
//  LuxPm-Demo
//
//  Created by Sandeep Ahuja on 04/08/21.
//

import Foundation

extension String {
  //    [A-Z0-9a-z._%+-]
  //    Quantifier — Matches between one and unlimited times, as many times as possible, giving back as needed
  //    A-Z a single character in the range between A (index 65) and Z (index 90) (case sensitive)
  //    0-9 a single character in the range between 0 (index 48) and 9 (index 57) (case sensitive)
  //    a-z a single character in the range between a (index 97) and z (index 122) (case sensitive)
  //    ._%+- matches a single character in the list ._%+- (case sensitive)

  //    @ matches the character @ literally (case sensitive)

  //    [A-Za-z0-9.-]
  //    Quantifier — Matches between one and unlimited times, as many times as possible, giving back as needed (greedy)
  //    A-Z a single character in the range between A (index 65) and Z (index 90) (case sensitive)
  //    a-z a single character in the range between a (index 97) and z (index 122) (case sensitive)
  //    0-9 a single character in the range between 0 (index 48) and 9 (index 57) (case sensitive)
  //    .- matches a single character in the list .- (case sensitive)

  //    . matches any character (except for line terminators)

  var isEmailValid: Bool {
    do {
      let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
      return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
    } catch {
      return false
    }
  }
}
