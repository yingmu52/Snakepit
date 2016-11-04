import UIKit

public protocol SnakepitEmptyStateProtocol {
  var emptyStateView: UIView { get }
  func showEmptyState()
  func hideEmptyState()
}

extension SnakepitEmptyStateProtocol where Self: UITableViewController {
  public func showEmptyState() {
    tableView.backgroundView = emptyStateView
  }
  
  public func hideEmptyState() {
    tableView.backgroundView = nil
  }
}
