import Snakepit
import PlaygroundSupport
import UIKit

let vc = UIViewController()
let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
button.setTitle("hahaha", for: .normal)
var data = [Int]()
button.onTouch(for: .touchUpInside) {
  if data.count > 0 {
    data.removeLast()
  }
  print(data)
}
for _ in 1...10 {
  data += [10]
}
print(data)
for _ in 1...10 {
  button.sendActions(for: .touchUpInside)
}
vc.view.addSubview(button)
PlaygroundPage.current.liveView = vc.playgroundView()
