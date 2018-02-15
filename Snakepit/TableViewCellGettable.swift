import Foundation
import UIKit

public protocol TableViewCellGettable {
  func register<T: UITableViewCell>(cell: T.Type)
  func deque<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T
}

public extension TableViewCellGettable where Self: UITableView {
  func register<T: UITableViewCell>(cell: T.Type) {
    let nib = UINib(nibName: cell.identifier, bundle: Bundle(for: cell))
    register(nib, forCellReuseIdentifier: cell.identifier)
  }

  func deque<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? T else {
      fatalError("dequeueReusableCell fail")
    }
    return cell
  }
}

private extension UITableViewCell {
  static var identifier: String {
    return String(describing: self)
  }
}
