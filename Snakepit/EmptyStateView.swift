//
//  EmptyStateView.swift
//  Snakepit
//
//  Created by Xinyi Zhuang on 2018/4/9.
//  Copyright © 2018 x52. All rights reserved.
//

import UIKit

public protocol SnakepitEmptyStateProtocol {
  var emptyStateView: UIView { get }
  func showEmptyState()
  func hideEmptyState()
}

public extension SnakepitEmptyStateProtocol where Self: UITableViewController {
  func showEmptyState() {
    tableView.backgroundView = emptyStateView
    tableView.tableFooterView = .init(frame: .zero)
  }

  func hideEmptyState() {
    tableView.backgroundView = nil
  }
}
