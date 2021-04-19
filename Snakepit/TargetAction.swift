import Foundation
import UIKit

public typealias Action = () -> Void
private var actionKey: Void?

class ActionWrapper { // wraps @objc function call to executing a closure
  let closure: Action
  init (_ closure: @escaping Action) {
    self.closure = closure
  }
  @objc func action() {
    closure()
  }
}

protocol TargetActionProtocol {
  func currentWrapper(for closure: @escaping Action) -> ActionWrapper
}

extension TargetActionProtocol {
  func currentWrapper(for closure: @escaping Action) -> ActionWrapper {
    guard let wrapper = objc_getAssociatedObject(self, &actionKey) as? ActionWrapper else {
      let newWrapper = ActionWrapper(closure)
      objc_setAssociatedObject(self, &actionKey, newWrapper, .OBJC_ASSOCIATION_RETAIN)
      return newWrapper
    }
    return wrapper
  }
}

extension UIControl: TargetActionProtocol {
  public func onTouch(for controlEvents: UIControl.Event, _ closure: @escaping Action) {
    let wrapper = currentWrapper(for: closure)
    addTarget(wrapper, action: #selector(wrapper.action), for: controlEvents) // it is safe with same input!
  }
}

extension UIGestureRecognizer: TargetActionProtocol {
  public func onTouch(_ closure: @escaping Action) {
    let wraper = currentWrapper(for: closure)
    addTarget(wraper, action: #selector(wraper.action))
  }
}

extension UIBarButtonItem: TargetActionProtocol {
  public convenience init(image: UIImage?, style: UIBarButtonItem.Style, _ action: @escaping Action) {
    self.init(image: image, style: style, target: nil, action: nil)
    self.onTouch(action)
  }

  public convenience init(title: String?, style: UIBarButtonItem.Style, _ action: @escaping Action) {
    self.init(title: title, style: style, target: nil, action: nil)
    self.onTouch(action)
  }

  public func onTouch(_ action: @escaping Action) {
    let wrapper = currentWrapper(for: action)
    self.target = wrapper
    self.action = #selector(wrapper.action)
  }
}
