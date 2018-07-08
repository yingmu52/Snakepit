import Foundation
import Snakepit
import UIKit
import PlaygroundSupport

let vc = UIViewController()
//vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 600)
vc.view.backgroundColor = .white

let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 44))
button.onTouch(for: .touchUpInside) {
  vc.showAlert("button pressed").cancelAction(title: "Cancel")
}
button.setTitle("Button", for: .normal)
button.backgroundColor = .orange
vc.view.addSubview(button)

let tap = UITapGestureRecognizer()
tap.onTouch {
  vc.showAlert("tap detected").cancelAction(title: "Cancel")
}
vc.view.addGestureRecognizer(tap)

vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "item", style: .plain) {
  vc.showAlert("bar button item pressed").cancelAction(title: "Cancel")
}
PlaygroundPage.current.liveView = UINavigationController(rootViewController: vc)

