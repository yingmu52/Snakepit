import UIKit

public final class SnakepitTableViewController<T, Cell: UITableViewCell>: UITableViewController {
  public typealias ConfigBlock = (Cell, T) -> Void
  public typealias SelectBlock = (T) -> Void

  public var didSelect: SelectBlock?

  private let reuseIdentifier = String(describing: self)
  private var items = [T]()
  private var configure: ConfigBlock

  public init(dataSource: [T], cellConfigBlock: @escaping ConfigBlock) {
    items = dataSource
    configure = cellConfigBlock
    super.init(style: .plain)
    tableView.tableFooterView = .init(frame: CGRect.zero)
    tableView.register(cell: Cell.self)
  }

  public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
      let item = items[indexPath.row]
      let cell = tableView.deque(cell: Cell.self, for: indexPath)
      configure(cell, item)
      return cell
  }

  public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    didSelect?(items[indexPath.row])
  }

  override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
