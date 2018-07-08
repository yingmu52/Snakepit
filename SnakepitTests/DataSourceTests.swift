import XCTest
@testable import Snakepit

final class IntTableCell: UITableViewCell, ConfigurableCell {
  var value: Int = 0
  func configure(with value: Int) {
    self.value = value
  }
}

final class IntCollectionCell: UICollectionViewCell, ConfigurableCell {
  var value: Int = 0
  func configure(with value: Int) {
    self.value = value
  }
}

final class IntDataSource: DataSource {
  override func registerCell(for tableView: UITableView) {
    tableView.register(cell: IntTableCell.self)
  }

  override func registerCell(for collectionView: UICollectionView?) {
    collectionView?.register(cell: IntCollectionCell.self)
  }
}

class DataSourceTests: XCTestCase {
  let dataSource = IntDataSource()
  let tableView = UITableView()
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

  override func setUp() {
    super.setUp()
    dataSource.registerCell(for: tableView)
    dataSource.registerCell(for: collectionView)

    dataSource.appendRow(value: 1, cellClass: IntTableCell.self, toSection: 0)
    dataSource.appendRow(value: 2, cellClass: IntTableCell.self, toSection: 0)
    dataSource.appendSection(values: [1, 2, 3], cellClass: IntTableCell.self)
    dataSource.set(values: [1, 2, 3], cellClass: IntTableCell.self, inSection: 5)
  }

  func testTableViewDataSourceMethods() {
    XCTAssertEqual(6, dataSource.numberOfSections(in: tableView))
    XCTAssertEqual(2, dataSource.tableView(tableView, numberOfRowsInSection: 0))
    XCTAssertEqual(3, dataSource.tableView(tableView, numberOfRowsInSection: 1))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 2))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 3))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 4))
    XCTAssertEqual(3, dataSource.tableView(tableView, numberOfRowsInSection: 5))
  }

  func testCollectionViewDataSourceMethods() {
    XCTAssertEqual(6, dataSource.numberOfSections(in: collectionView))
    XCTAssertEqual(2, dataSource.collectionView(collectionView, numberOfItemsInSection: 0))
    XCTAssertEqual(3, dataSource.collectionView(collectionView, numberOfItemsInSection: 1))
    XCTAssertEqual(0, dataSource.collectionView(collectionView, numberOfItemsInSection: 2))
    XCTAssertEqual(0, dataSource.collectionView(collectionView, numberOfItemsInSection: 3))
    XCTAssertEqual(0, dataSource.collectionView(collectionView, numberOfItemsInSection: 4))
    XCTAssertEqual(3, dataSource.collectionView(collectionView, numberOfItemsInSection: 5))
  }

  func testSubscript_IndexPath() {
    XCTAssertEqual(1, dataSource[IndexPath(item: 0, section: 0)] as? Int)
    XCTAssertEqual(2, dataSource[IndexPath(item: 1, section: 0)] as? Int)
    XCTAssertEqual(1, dataSource[IndexPath(item: 0, section: 1)] as? Int)
    XCTAssertEqual(2, dataSource[IndexPath(item: 1, section: 1)] as? Int)
    XCTAssertEqual(3, dataSource[IndexPath(item: 2, section: 1)] as? Int)
    XCTAssertEqual(1, dataSource[IndexPath(item: 0, section: 5)] as? Int)
    XCTAssertEqual(2, dataSource[IndexPath(item: 1, section: 5)] as? Int)
    XCTAssertEqual(3, dataSource[IndexPath(item: 2, section: 5)] as? Int)
  }

  func testNumberOfItems() {
    XCTAssertEqual(8, dataSource.totalNumberOfItems)
  }

  func testClearValues() {
    dataSource.clearValues()
    XCTAssertEqual(0, dataSource.totalNumberOfItems)
  }

  func testClearValuesInSection() {
    dataSource.clearValues(section: 0)
    XCTAssertEqual(6, dataSource.numberOfSections(in: tableView))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 0))
    XCTAssertEqual(3, dataSource.tableView(tableView, numberOfRowsInSection: 1))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 2))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 3))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 4))
    XCTAssertEqual(3, dataSource.tableView(tableView, numberOfRowsInSection: 5))
  }

  func testAppendStaticRow() {
    dataSource.appendStaticRow(cellIdentifier: "Test", toSection: 0)
    XCTAssertEqual(6, dataSource.numberOfSections(in: tableView))

    XCTAssertEqual(3, dataSource.tableView(tableView, numberOfRowsInSection: 0))
    XCTAssertEqual("Test", dataSource.reusableId(item: 2, section: 0))

    XCTAssertEqual(3, dataSource.tableView(tableView, numberOfRowsInSection: 1))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 2))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 3))
    XCTAssertEqual(0, dataSource.tableView(tableView, numberOfRowsInSection: 4))
    XCTAssertEqual(3, dataSource.tableView(tableView, numberOfRowsInSection: 5))
  }
}
