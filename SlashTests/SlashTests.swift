//
//  SlashTests.swift
//  SlashTests
//
//  Created by Xinyi Zhuang on 12/02/2018.
//  Copyright © 2018 x52. All rights reserved.
//

import XCTest
import Slash

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
    let viewController = Story.Main.get(TestViewController.self)
    XCTAssertNotNil(viewController)
    XCTAssertEqual(viewController.testNumber, 10)
  }

  func testTableViewCellGettable() {
    let controller = TableViewController(style: .plain)
    guard  let tableView = controller.tableView else {
      return XCTFail()
    }
    let indexPath = IndexPath(row: 99, section: 0)
    let cell = tableView.deque(cell: TestCell.self, for: indexPath)
    XCTAssertNotNil(cell)
  }
}
