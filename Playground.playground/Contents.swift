import PlaygroundSupport
import Snakepit
import UIKit

class TestViewController: UIViewController {
  override func viewDidLoad() {
    view.backgroundColor = .gray
    let button = UIButton(frame: CGRect(x: 20, y: 200, width: 100, height: 44))
    button.setTitle("press", for: .normal)
    button.backgroundColor = .orange
    button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    view.addSubview(button)
  }

  @objc func pressed() {
    showAlert(
      title: "title",
      message: "ahadfajsdfkadf;aksdf;asdjf",
      textFieldPlaceholder: "haha",
      type: .alert) { (action, text) in
        print(action.title!)
        print(text)
    }
  }
}

PlaygroundPage.current.liveView = TestViewController().playgroundView(
  device: .phone4_7inch,
  orientation: .portrait
)
