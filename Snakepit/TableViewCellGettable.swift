import Foundation
import UIKit

public protocol TableViewCellGettable {
  func register<T: UITableViewCell>(cell: T.Type)
  func deque<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T
}

extension UITableView: TableViewCellGettable {
  public func register<T: UITableViewCell>(cell: T.Type) {
    guard let nib = cell.nib else {
      return register(cell, forCellReuseIdentifier: cell.reuseId)
    }
    register(nib, forCellReuseIdentifier: cell.reuseId)
  }
  
  public func deque<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: cell.reuseId, for: indexPath) as? T else {
      fatalError("dequeueReusableCell fail")
    }
    return cell
  }
}

extension UITableViewCell {
  static var reuseId: String {
    return String(describing: self)
  }
  
  static var nib: UINib? {
    let bundle = Bundle(for: self)
    guard bundle.path(forResource: reuseId, ofType: "nib") != nil else { return nil }
    return UINib(nibName: reuseId, bundle: bundle)
  }
}
