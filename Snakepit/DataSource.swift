import Foundation
import UIKit

open class DataSource: NSObject, UITableViewDataSource, UICollectionViewDataSource {

  private var values: [[(value: Any, reuseId: String)]] = []
  open func configure(collectionViewCell cell: UICollectionViewCell, with value: Any) {}
  open func configure(tableViewCell cell: UITableViewCell, with value: Any) {}
  open func registerCell(for collectionView: UICollectionView?) {}
  open func registerCell(for tableView: UITableView) {}

  @discardableResult
  public final func prependRow
    <Cell: ConfigurableCell, Value>
    (value: Value, cellClass: Cell.Type, toSection section: Int) -> IndexPath
    where Cell.Value == Value {

      padValues(for: section)
      values[section].insert((value, cellClass.reuseID), at: 0)
      return IndexPath(row: 0, section: section)
  }

  @discardableResult
  public final func appendRow
    <Cell: ConfigurableCell, Value>
    (value: Value, cellClass: Cell.Type, toSection section: Int) -> IndexPath
    where Cell.Value == Value {

      padValues(for: section)
      values[section].append((value, cellClass.reuseID))
      return IndexPath(row: values[section].count - 1, section: section)
  }

  public final func appendSection
    <Cell: ConfigurableCell, Value>
    (values: [Value], cellClass: Cell.Type)
    where Cell.Value == Value {

      self.values.append(values.map { ($0, cellClass.reuseID) })
  }

  public final func set
    <Cell: ConfigurableCell, Value>
    (values: [Value], cellClass: Cell.Type, inSection section: Int)
    where Cell.Value == Value {

      padValues(for: section)
      self.values[section] = values.map { ($0, cellClass.reuseID) }
  }

  public final func set
    <Cell: ConfigurableCell, Value>
    (value: Value, cellClass: Cell.Type, inSection section: Int, row: Int)
    where Cell.Value == Value {

      values[section][row] = (value, cellClass.reuseID)
  }

  public final func appendStaticRow(cellIdentifier: String, toSection section: Int) {
    padValues(for: section)
    self.values[section].append(((), cellIdentifier))
  }

  final func reusableId(item: Int, section: Int) -> String? {
    if !self.values.isEmpty && self.values.count >= section &&
      !self.values[section].isEmpty && self.values[section].count >= item {

      return self.values[section][item].reuseId
    }
    return nil
  }

  // MARK: Read Data Source

  public final subscript(indexPath: IndexPath) -> Any {
    return values[indexPath.section][indexPath.item].value
  }

  public final subscript(section: Int) -> [Any] {
    return values[section].map { $0.value }
  }

  public final var totalNumberOfItems: Int {
    return values.reduce(0) { accum, section in accum + section.count }
  }

  // MARK: Util

  private func padValues(for section: Int) {
    guard values.count <= section else { return }
    for _ in values.count...section {
      values.append([])
    }
  }

  public final func clearValues() {
    values = [[]]
  }

  public final func clearValues(section: Int) {
    padValues(for: section)
    values[section] = []
  }

  // MARK: UICollectionViewDataSource methods

  public final func numberOfSections(in collectionView: UICollectionView) -> Int {
    return values.count
  }

  public final
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return values[section].count
  }

  public final func collectionView(_ collectionView: UICollectionView,
                                   cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let (value, reuseId) = values[indexPath.section][indexPath.item]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath)
    configure(collectionViewCell: cell, with: value)
    return cell
  }

  // MARK: UITableViewDataSource methods

  public final func numberOfSections(in tableView: UITableView) -> Int {
    return values.count
  }

  public final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return values[section].count
  }

  public final
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let (value, reuseId) = values[indexPath.section][indexPath.item]
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
    configure(tableViewCell: cell, with: value)
    return cell
  }
}
