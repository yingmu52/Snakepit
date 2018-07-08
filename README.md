[![Build Status](https://app.bitrise.io/app/971d975c5f4519e4/status.svg?token=gVcICCdDNPnUeYe-ZhP15Q&branch=master)](https://www.bitrise.io/app/971d975c5f4519e4)
![ios](https://cocoapod-badges.herokuapp.com/p/Snakepit/badge.png)
![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/Snakepit.svg)](#cocoapods)
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)


# Installation 

```
pod 'Snakepit'
```

# Examples

#### Use `AlertController` with chained promise style

```swift
  override func viewDidLoad() {
    super.viewDidLoad()

    showAlert("This is an alert")
      .cancelAction(title: "Cancel") { print("Cancel pressed") }
      .action(title: "Confirm") { print("Confirm pressed") }

    showActionSheet("This is an action sheet")
      .action(title: "option 1") { print("option1 pressed") }
      .action(title: "option 2") { print("option2 pressed") }
      .action(title: "option 3") { print("option3 pressed") }
      .cancelAction(title: "Cancel") { print("Cancel pressed") }

  }
```

#### Typesafe Storyboard

> Let's say you have a `UITabBarController` in `Main.storyboard` called `TabBarViewController`, make sure its storyboard ID is also `TabBarViewController`

```swift

// Step 1
enum Storyboard: String, StoryboardGettable { 
  case Main

  var bundle: Bundle? {
    return Bundle.main 
  }
}

// Step 2
let tabVc = Storyboard.Main.get(TabbarViewController.self)
```

#### Typesafe TableViewCell

> Let's say you have a custom prototype cell `MyCell`, make sure its reuse identifier is `MyCell`.

```swift
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let myCell = tableView.deque(cell: MyCell.self, for: indexPath)
    return myCell
  }

```

you can use `tableView.register(cell: MyCell.self)` in `viewDidLoad` if you want to register a cell from a `.xib`

#### Hex UIColor

```swift
UIColor(0xFF0000) // the same as UIColor.red
UIColor(0x00FF00) // the same as UIColor.green
UIColor(0x0000FF) // the same as UIColor.blue
```

#### Target-Action using closure

```swift
UIButton().onTouch(for: .touchUpInside) {
  print("button pressed")
}

UISwitch().onTouch(for: .valueChanged) {
  print("switch toggled")
}

UITapGestureRecognizer().onTouch {
  print("tap detected")
}


UIBarButtonItem(title: "item", style: .plain) {
  print("item pressed")
}
```

#### Typesafe UserDefault

> Let's say you want to store a `URL` in `UserDefault` with key `myURL` and a phone number (`String`) with key `phone`

```swift

// Define keys
enum UserDefaultsKey: String, UserDefaultsGettable {
  case myUrl
  case phone
  static var bundle: Bundle {
    return Bundle.main
  }
}

// Save to UserDefault
let url = URL(string: "www.google.com")
UserDefaultsKey.myUrl.set(url)

// Retrive from UserDefault
let myURL = UserDefaultsKey.myUrl.get(URL.self)

// Remove from UserDefault 
UserDefaultsKey.myUrl.remove()

```