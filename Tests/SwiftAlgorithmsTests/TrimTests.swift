//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Algorithms open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Algorithms
import XCTest

final class TrimTests: XCTestCase {

  func testEmpty() {
    let results_empty = ([] as [Int]).trimming { $0.isMultiple(of: 2) }
    XCTAssertEqual(results_empty, [])
  }

  func testNoMatch() {
    // No match (nothing trimmed).
    let results_nomatch = [1, 3, 5, 7, 9, 11, 13, 15].trimming {
      $0.isMultiple(of: 2)
    }
    XCTAssertEqual(results_nomatch, [1, 3, 5, 7, 9, 11, 13, 15])
  }

  func testNoTailMatch() {
    // No tail match (only trim head).
    let results_notailmatch = [1, 3, 5, 7, 9, 11, 13, 15].trimming { $0 < 10 }
    XCTAssertEqual(results_notailmatch, [11, 13, 15])
  }

  func testNoHeadMatch() {
    // No head match (only trim tail).
    let results_noheadmatch = [1, 3, 5, 7, 9, 11, 13, 15].trimming { $0 > 10 }
    XCTAssertEqual(results_noheadmatch, [1, 3, 5, 7, 9])
  }

  func testBothEndsMatch() {
    // Both ends match, some string of >1 elements do not (return that string).
    let results = [2, 10, 11, 15, 20, 21, 100].trimming { $0.isMultiple(of: 2) }
    XCTAssertEqual(results, [11, 15, 20, 21])
  }

  func testEverythingMatches() {
    // Everything matches (trim everything).
    let results_allmatch = [1, 3, 5, 7, 9, 11, 13, 15].trimming { _ in true }
    XCTAssertEqual(results_allmatch, [])
  }

  func testEverythingButOneMatches() {
    // Both ends match, one element does not (trim all except that element).
    let results_one = [2, 10, 12, 15, 20, 100].trimming { $0.isMultiple(of: 2) }
    XCTAssertEqual(results_one, [15])
  }
}
