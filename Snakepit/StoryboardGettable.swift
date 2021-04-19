import Foundation
import UIKit

public protocol StoryboardGettable {
  var bundle: Bundle? { get }
  func get<T: UIViewController>(_ type: T.Type) -> T
  var initialViewController: UIViewController { get }
}

private extension UIViewController {
  static var storyboardID: String {
    return description().components(separatedBy: ".").dropFirst().joined()
  }
}

public extension StoryboardGettable where Self: RawRepresentable, Self.RawValue == String {
    func get<T: UIViewController>(_ type: T.Type) -> T {
    let story = UIStoryboard(name: rawValue, bundle: Bundle(for: T.self))
    guard let viewController = story.instantiateViewController(withIdentifier: T.storyboardID) as? T else {
      fatalError("This view controller does not exist in the storyboard")
    }
    return viewController
  }

    var initialViewController: UIViewController {
    let story = UIStoryboard(name: rawValue, bundle: bundle)
    guard let viewController = story.instantiateInitialViewController() else {
      fatalError("This view controller does not exist in the storyboard")
    }
    return viewController
  }
}
