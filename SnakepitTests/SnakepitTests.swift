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
    let alert1 = vc.showAlert("ok")
    XCTAssertEqual(alert1.title, "ok")
    let alert2 = vc.showAlert("ok1", message: "msg1")
    XCTAssertEqual(alert2.title, "ok1")
    XCTAssertEqual(alert2.message, "msg1")
    let alert3 = vc
      .showAlert("ok3", message: "msg3")
      .action(title: "OK")
      .cancelAction(title: "cancel")
      .destructiveAction(title: "OK1")
    XCTAssertEqual(alert3.actions[0].title, "OK")
    XCTAssertEqual(alert3.actions[1].title, "cancel")
    XCTAssertEqual(alert3.actions[2].title, "OK1")
  }

  func testGenericTableViewControllerBasicUsage() {
    _ = SnakepitTableViewController(dataSource: [1, 2, 3]) { (cell, num) in
      cell.textLabel?.text = num.description
      cell.detailTextLabel?.text = num.description
    }
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
      return bundle
    }
  }

  func testUserDefault() {
    RegisteredKey.a.set(true)
    XCTAssertNil(RegisteredKey.a.get(String.self))
    XCTAssertEqual(RegisteredKey.a.get(Bool.self), true)
    XCTAssertNil(RegisteredKey.b.get(String.self))

    RegisteredKey.c.set("hiss")
    XCTAssertEqual(RegisteredKey.c.get(String.self), "hiss")

    let array = ["a", "b"]
    RegisteredKey.d.set(array)
    XCTAssertEqual(RegisteredKey.c.get([String].self)!, array)

    RegisteredKey.a.remove()
    RegisteredKey.b.remove()
    RegisteredKey.c.remove()
    RegisteredKey.d.remove()

    XCTAssertNil(RegisteredKey.a.get(Bool.self))
    XCTAssertNil(RegisteredKey.b.get(String.self))
    XCTAssertNil(RegisteredKey.c.get(String.self))
    XCTAssertNil(RegisteredKey.d.get([String].self))
  }

  func testUIColorExt() {
    XCTAssertTrue(UIColor(0xFF0000).rgb == UIColor.red.rgb)
    XCTAssertTrue(UIColor(0x00FF00).rgb == UIColor.green.rgb)
    XCTAssertTrue(UIColor(0x0000FF).rgb == UIColor.blue.rgb)
    XCTAssertTrue(UIColor(0xFF7F00).rgb == UIColor.orange.rgb)
  }

  func testPrettyDateString() {
    func dateFromString(_ s: String) -> Date {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
      dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
      return dateFormatter.date(from: s)!
    }

    let now = dateFromString("2016-04-14T00:00:00+0000")
    let dates = [
      "2016-04-14T00:00:59+0000",
      "2016-04-14T00:01:59+0000",
      "2016-04-14T00:05:52+0000",
      "2016-04-14T01:59:59+0000",
      "2016-04-14T03:52:52+0000",
      "2016-04-19T00:00:00+0000"
      ]
      .map { (s) -> Date in return dateFromString(s) }
    XCTAssertEqual(Date.prettyDatetestable(now: dates[0], target: now), "Just Now")
    XCTAssertEqual(Date.prettyDatetestable(now: dates[1], target: now), "1 minute ago")
    XCTAssertEqual(Date.prettyDatetestable(now: dates[2], target: now), "5 minutes ago")
    XCTAssertEqual(Date.prettyDatetestable(now: dates[3], target: now), "1 hour ago")
    XCTAssertEqual(Date.prettyDatetestable(now: dates[4], target: now), "3 hours ago")
    XCTAssertEqual(Date.prettyDatetestable(now: dates[5], target: now), "5 days ago")
  }
}
