import PlaygroundSupport
import Snakepit
import UIKit

let vc = UIViewController()
vc.view.backgroundColor = .orange
PlaygroundPage.current.liveView = vc.playgroundView(
  device: .phone3_5inch,
  orientation: .landscape
)
