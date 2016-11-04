import Foundation
import UIKit

public extension UIAlertController {
  public static func alert(_ name: String, message: String? = nil) -> UIAlertController {
    return UIAlertController(title: name, message: message, preferredStyle: .alert)
  }

  public static func sheet(_ name: String, message: String? = nil) -> UIAlertController {
    return UIAlertController(title: name, message: message, preferredStyle: .actionSheet)
  }

  func addAction(title: String,
                 style: UIAlertActionStyle = .default, handler: ((UIAlertAction) -> Void)? = nil) {
    addAction(UIAlertAction(title: title, style: style, handler: handler))
  }
}

public extension UIAlertController {
  @discardableResult
  public func action(title: String, handler: (() -> Void)? = nil) -> UIAlertController {
    addAction(title: title, style: .default) { _ in handler?() }
    return self
  }

  @discardableResult
  public func cancelAction(title: String, handler: (() -> Void)? = nil) -> UIAlertController {
    addAction(title: title, style: .cancel) { _ in handler?() }
    return self
  }

  @discardableResult
  public func destructiveAction(title: String, handler: (() -> Void)? = nil) -> UIAlertController {
    addAction(title: title, style: .destructive) { _ in handler?() }
    return self
  }
}

extension UIViewController {

  @discardableResult
  public func showAlert(_ name: String, message: String? = nil) -> UIAlertController {
    let alertController = UIAlertController.alert(name, message: message)
    present(alertController, animated: true, completion: nil)
    return alertController
  }

  @discardableResult
  public func showActionSheet(_ name: String, message: String? = nil) -> UIAlertController {
    let alertController = UIAlertController.sheet(name, message: message)
    present(alertController, animated: true, completion: nil)
    return alertController
  }
}
