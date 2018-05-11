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

extension SnakepitEmptyStateProtocol where Self: UITableViewController {
  public func showEmptyState() {
    tableView.backgroundView = emptyStateView
  }
  
  public func hideEmptyState() {
    tableView.backgroundView = nil
  }
}
