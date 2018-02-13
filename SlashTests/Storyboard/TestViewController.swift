//
//  TestViewController.swift
//  SlashTests
//
//  Created by Xinyi Zhuang on 12/02/2018.
//  Copyright © 2018 x52. All rights reserved.
//

import UIKit
import Slash

class TestViewController: UIViewController {
  var testNumber: Int {
    return 10
  }
}

extension UITableView: TableViewCellGettable {}

class TableViewController: UITableViewController {
  override init(style: UITableViewStyle) {
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
