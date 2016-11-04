import Foundation
import Snakepit
import UIKit
import PlaygroundSupport

var data = [UUID]()

for i in 1...100 {
  data += [.init()]
}

final class CustomCell: UITableViewCell {
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

let tvc = SnakepitTableViewController(dataSource: data) { (cell: CustomCell, object) in
  cell.textLabel?.text = object.uuidString
  cell.detailTextLabel?.text = object.customMirror.description
}
tvc.title = "hahah"

tvc.didSelect = { obj in
  tvc.showAlert(
    title: obj.uuidString,
    message: obj.hashValue.description,
    textFieldPlaceholder: "enter here",
    actions: [.ok, .cancel],
    type: .alert,
    didSelectWithText: { (action, text) in
      print(action.title)
      print(text)
  })
}

let nav = UINavigationController(rootViewController: tvc)
PlaygroundPage.current.liveView = nav.playgroundView()
