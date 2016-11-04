import Foundation
import UIKit

@available(iOS 10.0, *)
public extension UIViewController {
  public func playgroundView(
    device: Device = .phone4_7inch,
    orientation: Orientation = .portrait,
    contentSizeCategory: UIContentSizeCategory? = nil,
    additionalTraits: UITraitCollection? = nil) -> UIViewController {

    let parentSize = CGSize.deviceDimension(device, orientation)
    let (parent, child) = (UIViewController(), self)

    parent.view.addSubview(child.view)
    parent.view.frame.size = parentSize
    parent.preferredContentSize = parentSize
    parent.addChildViewController(child)

    if let moreTraits = additionalTraits, let category = contentSizeCategory {
      let allTraits = UITraitCollection(traitsFrom: [
        .traits(device, orientation),
        moreTraits,
        .init(preferredContentSizeCategory: category)
        ])
      parent.setOverrideTraitCollection(allTraits, forChildViewController: child)
      child.view.translatesAutoresizingMaskIntoConstraints = false
      parent.view.translatesAutoresizingMaskIntoConstraints = false
    }

    NSLayoutConstraint.activate([
      child.view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor),
      child.view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor),
      child.view.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor),
      child.view.topAnchor.constraint(equalTo: parent.view.topAnchor)
      ])

    return parent
  }
}

public enum Device {
  case phone3_5inch
  case phone4inch
  case phone4_7inch
  case phone5_5inch
  case phone5_8inch
  case pad
}

public enum Orientation {
  case portrait
  case landscape
}

extension CGSize {
  init(width w: CGFloat, height h: CGFloat, orientation: Orientation) {
    switch orientation {
    case .portrait:
      self.init(width: w, height: h)
    case .landscape:
      self.init(width: h, height: w)
    }
  }

  static func deviceDimension(_ device: Device, _ orientation: Orientation) -> CGSize {
    var size: CGSize
    switch (device, orientation) {
    case (.phone3_5inch, let o):
      size = .init(width: 320, height: 480, orientation: o)
    case (.phone4inch, let o):
      size = .init(width: 320, height: 568, orientation: o)
    case (.phone4_7inch, let o):
      size = .init(width: 375, height: 667, orientation: o)
    case (.phone5_5inch, let o):
      size = .init(width: 414, height: 736, orientation: o)
    case (.phone5_8inch, let o):
      size = .init(width: 375, height: 812, orientation: o)
    case (.pad, let o):
      size = .init(width: 768, height: 1024, orientation: o)
    }
    return size
  }
}

extension UITraitCollection {
  static func traits(_ device: Device, _ orientation: Orientation) -> UITraitCollection {
    switch (device, orientation) {
    case (.phone4inch, .portrait),
         (.phone3_5inch, .portrait),
         (.phone4_7inch, .portrait),
         (.phone5_5inch, .portrait),
         (.phone5_8inch, .portrait):
      return .init(traitsFrom: [
        .init(horizontalSizeClass: .compact),
        .init(verticalSizeClass: .regular),
        .init(userInterfaceIdiom: .phone)
        ])
    case (.phone4inch, .landscape),
         (.phone3_5inch, .landscape),
         (.phone4_7inch, .landscape):
      return .init(traitsFrom: [
        .init(horizontalSizeClass: .compact),
        .init(verticalSizeClass: .compact),
        .init(userInterfaceIdiom: .phone)
        ])
    case (.phone5_5inch, .landscape),
         (.phone5_8inch, .landscape):
      return .init(traitsFrom: [
        .init(horizontalSizeClass: .regular),
        .init(verticalSizeClass: .compact),
        .init(userInterfaceIdiom: .phone)
        ])
    case (.pad, _):
      return .init(traitsFrom: [
        .init(horizontalSizeClass: .regular),
        .init(verticalSizeClass: .regular),
        .init(userInterfaceIdiom: .pad)
        ])
    }
  }
}
