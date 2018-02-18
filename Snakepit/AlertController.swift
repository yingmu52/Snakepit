import Foundation
import UIKit

public extension UIViewController {
  public func showAlert(
    title: String,
    message: String? = nil,
    actions: [(String, UIAlertActionStyle)]? = nil,
    type: UIAlertControllerStyle? = nil,
    didSelectAlertAction: ((UIAlertAction) -> Void)? = nil)
    -> UIAlertController {

      let alertController = UIAlertController(title: title, message: message, preferredStyle: type ?? .alert)
      for (title, style) in actions ?? [("OK", .default)] {
        let action = UIAlertAction(title: title, style: style) {
          didSelectAlertAction?($0)
        }
        alertController.addAction(action)
      }
      present(alertController, animated: true, completion: nil)
      return alertController
  }
  
  public func showAlert(
    title: String,
    message: String? = nil,
    textFieldPlaceholder: String,
    actions: [(String, UIAlertActionStyle)]? = nil,
    type: UIAlertControllerStyle? = nil,
    didSelectAlertActionWithText: @escaping (UIAlertAction, String) -> Void)
    -> UIAlertController {

      let alertController = UIAlertController(title: title, message: message, preferredStyle: type ?? .alert)
      for (title, style) in actions ?? [("OK", .default)] {
        let action = UIAlertAction(title: title, style: style) {
          didSelectAlertActionWithText($0, alertController.textFields?.last?.text ?? "")
        }
        alertController.addAction(action)
      }
      alertController.addTextField { $0.placeholder = textFieldPlaceholder }
      present(alertController, animated: true, completion: nil)
      return alertController
  }
}
