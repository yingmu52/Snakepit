import Foundation
import UIKit

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
