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

  @available(*, deprecated, message: "please use promise style of UIAlertController")
  @discardableResult public func showAlert(
    title: String,
    message: String? = nil,
    actions: [AlertButtonType]? = nil,
    type: UIAlertControllerStyle? = nil,
    didSelect: ((UIAlertAction) -> Void)? = nil)
    -> UIAlertController {

      let alertController = UIAlertController(title: title, message: message, preferredStyle: type ?? .alert)
      (actions ?? [.ok]).forEach {
        let action = UIAlertAction(title: $0.description, style: $0.type) {
          didSelect?($0)
        }
        alertController.addAction(action)
      }
      present(alertController, animated: true, completion: nil)
      return alertController
  }

  @available(*, deprecated, message: "please use promise style of UIAlertController")
  @discardableResult public func showAlert(
    title: String,
    message: String? = nil,
    textFieldPlaceholder: String,
    actions: [AlertButtonType]? = nil,
    type: UIAlertControllerStyle? = nil,
    didSelectWithText: @escaping (UIAlertAction, String) -> Void)
    -> UIAlertController {

      let alertController = UIAlertController(title: title, message: message, preferredStyle: type ?? .alert)
      (actions ?? [.ok]).forEach {
        let action = UIAlertAction(title: $0.description, style: $0.type) {
          didSelectWithText($0, alertController.textFields?.last?.text ?? "")
        }
        alertController.addAction(action)
      }
      alertController.addTextField { $0.placeholder = textFieldPlaceholder }
      present(alertController, animated: true, completion: nil)
      return alertController
  }
}

@available(*, deprecated, message: "please use promise style of UIAlertController")
public enum AlertButtonType: CustomStringConvertible {
  case ok
  case cancel
  case done
  case delete
  case dismiss
  case custom(String, UIAlertActionStyle)

  var type: UIAlertActionStyle {
    switch self {
    case .ok, .done:
      return .default
    case .cancel, .dismiss:
      return .cancel
    case .delete  :
      return .destructive
    case .custom(_, let style):
      return style
    }
  }

  public var description: String {
    switch self {
    case .ok: return "OK"
    case .cancel: return "Cancel"
    case .done: return "Done"
    case .delete: return "Delete"
    case .dismiss: return "Dismiss"
    case .custom(let title, _): return title
    }
  }
}
