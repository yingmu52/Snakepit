import UIKit
import Snakepit

class TestViewController: UIViewController {
  var testNumber: Int {
    return 10
  }
}

class TableViewController: UITableViewController {
  override init(style: UITableView.Style) {
    super.init(style: style)
    tableView.register(cell: TestCell.self)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.deque(cell: TestCell.self, for: indexPath)
    cell.index = indexPath.row
    return cell
  }
}
