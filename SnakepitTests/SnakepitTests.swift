//
//  SlashTests.swift
//  SlashTests
//
//  Created by Xinyi Zhuang on 12/02/2018.
//  Copyright © 2018 x52. All rights reserved.
//

import XCTest
@testable import Snakepit

class SnakepitTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  enum Story: String, StoryboardGettable {
    var bundle: Bundle? {
      return Bundle.init(for: TableViewController.self)
    }
    case Main
  }

  func testStoryboardGettable() {
    let viewController = Story.Main.get(TestViewController.self)
    XCTAssertNotNil(viewController)
    XCTAssertEqual(viewController.testNumber, 10)
    XCTAssertNotNil(Story.Main.initialViewController)
  }

  func testTableViewCellGettable() {
    let controller = TableViewController(style: .plain)
    let indexPath = IndexPath(row: 99, section: 0)
    let cell = controller.tableView.deque(cell: TestCell.self, for: indexPath)
    XCTAssertNotNil(cell)
    XCTAssertNotNil(TestCell.nib)
  }

  func testAlertController() {
    let vc = UIViewController()
    let alert1 = vc.showAlert(title: "ok")
    XCTAssertEqual(alert1.title, "ok")
    let alert2 = vc.showAlert(title: "ok1", message: "msg1")
    XCTAssertEqual(alert2.title, "ok1")
    XCTAssertEqual(alert2.message, "msg1")
    let alert3 = vc.showAlert(
      title: "ok3",
      message: "msg3",
      actions: [.ok, .custom("OK1", .destructive)]
    )
    XCTAssertEqual(alert3.actions.first?.title, "OK")
    XCTAssertEqual(alert3.actions.last?.title, "OK1")
    let alert4 = vc.showAlert(title: String(), textFieldPlaceholder: "12345") { _, _  in }
    XCTAssertEqual(alert4.textFields?.last?.placeholder, "12345")
  }

  func testGenericTableViewController() {
    var data = [String]()
    for ind in 0...9 {
      data += [ind.description]
    }
    let tvc = SnakepitTableViewController(dataSource: data) { (cell: TestCell, uuid) in
      cell.textLabel?.text = uuid
    }
    var selectedItem = [String]()
    tvc.didSelect = { uuid in
      XCTAssertNotNil(data.index(of: uuid))
      guard let row = selectedItem.index(of: uuid) else {
        return XCTFail("\(uuid) does not exist in \(selectedItem)")
      }
      selectedItem.remove(at: row)
    }

    for i in 0...9 {
      let indexPath = IndexPath(row: i, section: 0)
      let cell = tvc.tableView(tvc.tableView, cellForRowAt: indexPath)
      let uuid = data[indexPath.row]
      XCTAssertEqual(cell.textLabel?.text, uuid)
      selectedItem += [uuid]
      tvc.tableView(tvc.tableView, didSelectRowAt: indexPath)
    }
    XCTAssertTrue(selectedItem.count == 0)
  }
}
