import Foundation
import UIKit

public extension UIAlertController {
  public class func alert(_ name: String, message: String? = nil, acceptMessage: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
    let action = UIAlertAction(title: acceptMessage, style: .cancel, handler: handler)
    return UIAlertController.alert(name, message: message, actions: [action])
  }

  public class func alert(_ name: String, message: String? = nil, actions: [UIAlertAction]) -> UIAlertController {
    let alertController =  UIAlertController(title: name, message: message, preferredStyle: .alert)
    actions.forEach(alertController.addAction)
    return alertController
  }

  public class func alert(_ name: String, message: String? = nil, actionHandler: (() -> [UIAlertAction])) -> UIAlertController {
      return UIAlertController.alert(name, message: message, actions: actionHandler())
  }

  public class func sheet( _ name: String, message: String? = nil, actions: [UIAlertAction]? = nil) -> UIAlertController {
      let alertController =  UIAlertController(title: name, message: message, preferredStyle: .actionSheet)
      actions?.forEach(alertController.addAction)
      return alertController
  }

  public class func sheet( _ name: String, message: String? = nil, actionHandler: (() -> [UIAlertAction])) -> UIAlertController {
      return UIAlertController.sheet(name, message: message, actions: actionHandler())
  }

  func action(title: String, style: UIAlertActionStyle = .default, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
      addAction(title: title, style: style, handler: handler)
      return self
  }

  func okable(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
    addOk(handler: handler)
    return self
  }

  func cancelable(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
    addCancel(handler: handler)
    return self
  }

  func addAction(title: String, style: UIAlertActionStyle = .default, handler: ((UIAlertAction) -> Void)? = nil) {
    let action = UIAlertAction(title: title, style: style, handler: handler)
    addAction(action)
  }

  func addOk(handler: ((UIAlertAction) -> Void)? = nil) {
    addAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: handler)
  }

  func addCancel(handler: ((UIAlertAction) -> Void)? = nil) {
    addAction(
      title: NSLocalizedString("Cancel", comment: ""),
      style: .cancel,
      handler: handler
    )
  }
}

extension UIAlertAction {

  convenience init(title: String?, handler: ((UIAlertAction) -> Void)? = nil) {
    self.init(title: title, style: .default, handler: handler)
  }

  func appending(title: String, style: UIAlertActionStyle = .default,
                 handler: ((UIAlertAction) -> Void)? = nil) -> [UIAlertAction] {
    return [self, UIAlertAction(title: title, style: style, handler: handler)]
  }
}

extension Collection where Iterator.Element == UIAlertAction {
  func appending(title: String, style: UIAlertActionStyle = .default,
                 handler: ((UIAlertAction) -> Void)? = nil) -> [UIAlertAction] {
    return self + [UIAlertAction(title: title, style: style, handler: handler)]
  }
}


extension UIViewController {
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
