//
//  TestCell.swift
//  SlashTests
//
//  Created by Xinyi Zhuang on 13/02/2018.
//  Copyright © 2018 x52. All rights reserved.
//

import UIKit

class TestCell: UITableViewCell {
  var index: Int?

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: "TestCell")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
