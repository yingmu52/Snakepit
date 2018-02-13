//
//  Storyboard.swift
//  Slash
//
//  Created by Xinyi Zhuang on 12/02/2018.
//  Copyright © 2018 x52. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardGettable {
  func get<T: UIViewController>(_ type: T.Type) -> T
}

private extension UIViewController {
  static var storyboardID: String {
    return description().components(separatedBy: ".").dropFirst().joined()
  }
}

public extension StoryboardGettable where Self: RawRepresentable, Self.RawValue == String {
  public func get<T: UIViewController>(_ type: T.Type) -> T {
    let story = UIStoryboard(name: rawValue, bundle: Bundle(for: T.self))
    guard let viewController = story.instantiateViewController(withIdentifier: T.storyboardID) as? T else {
      fatalError("This view controller does not exist in the storyboard")
    }
    return viewController
  }
}
