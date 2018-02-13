//
//  SlashTests.swift
//  SlashTests
//
//  Created by Xinyi Zhuang on 12/02/2018.
//  Copyright © 2018 x52. All rights reserved.
//

import XCTest
@testable import Slash

class SlashTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testStoryboardGettable() {
    enum Story: String, StoryboardGettable {
      case Main
    }
    XCTAssertEqual(Story.Main.get(TestViewController.self).testNumber, 10)
  }
}
