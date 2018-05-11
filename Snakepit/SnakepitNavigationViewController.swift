import UIKit

public class SnakepitNavigationViewController: UINavigationController {
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    let target = interactivePopGestureRecognizer?.delegate
    let selector = Selector(("handleNavigationTransition:"))
    let targetView = interactivePopGestureRecognizer?.view
    let pan = UIPanGestureRecognizer(target: target, action: selector)
    pan.delegate = self
    targetView?.addGestureRecognizer(pan)
    interactivePopGestureRecognizer?.isEnabled = false
  }
}

extension SnakepitNavigationViewController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard let pan = gestureRecognizer as? UIPanGestureRecognizer else { return false }
    let translation = pan.translation(in: pan.view)
    if translation.x <= 0 { return false }
    if value(forKey: "_isTransitioning") as? Bool == true { return false }
    return childViewControllers.count == 1 ? false : true
  }
}
