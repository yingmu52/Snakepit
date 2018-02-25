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

  enum RegisteredKey: String, UserDefaultsGettable {
    case a
    case b
    case c
    case d
    static var bundle: Bundle {
      let bundle = Bundle(for: TableViewController.self)
      print(String(describing: bundle.bundleIdentifier))
      return bundle
    }
  }

  func testUserDefault() {
    RegisteredKey.a.set(userDefault: true)
    XCTAssertNil(RegisteredKey.a.get(userDefault: String.self))
    XCTAssertEqual(RegisteredKey.a.get(userDefault: Bool.self), true)
    XCTAssertNil(RegisteredKey.b.get(userDefault: String.self))

    RegisteredKey.c.set(userDefault: "hiss")
    XCTAssertEqual(RegisteredKey.c.get(userDefault: String.self), "hiss")

    let array = ["a", "b"]
    RegisteredKey.d.set(userDefault: array)
    XCTAssertEqual(RegisteredKey.c.get(userDefault: [String].self)!, array)

    RegisteredKey.a.remove()
    RegisteredKey.b.remove()
    RegisteredKey.c.remove()
    RegisteredKey.d.remove()

    XCTAssertNil(RegisteredKey.a.get(userDefault: Bool.self))
    XCTAssertNil(RegisteredKey.b.get(userDefault: String.self))
    XCTAssertNil(RegisteredKey.c.get(userDefault: String.self))
    XCTAssertNil(RegisteredKey.d.get(userDefault: [String].self))
    print(UserDefaults.standard.dictionaryRepresentation())
  }

  func testUIColorExt() {
    XCTAssertTrue(UIColor(0xFF0000).rgb == UIColor.red.rgb)
    XCTAssertTrue(UIColor(0x00FF00).rgb == UIColor.green.rgb)
    XCTAssertTrue(UIColor(0x0000FF).rgb == UIColor.blue.rgb)
    XCTAssertTrue(UIColor(0xFF7F00).rgb == UIColor.orange.rgb)
  }
}
