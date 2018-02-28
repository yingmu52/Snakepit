import Foundation
import UIKit

extension UIColor {
  /// Convert Hex to UIColor i.e UIColor(0xFF0000), default alpha = 1
  public convenience init(_ hex: UInt32, alpha: CGFloat = 1) {
    let divisor = CGFloat(255)
    let r = CGFloat((hex & 0xFF0000) >> 16) / divisor
    let g = CGFloat((hex & 0x00FF00) >> 8 ) / divisor
    let b = CGFloat(hex & 0x0000FF        ) / divisor
    self.init(red: r, green: g, blue: b, alpha: alpha)
  }

  typealias RGB = (CGFloat, CGFloat, CGFloat)
  var rgb: RGB {
    let zero = CGFloat(0)
    var (r, g, b, a) = (zero, zero, zero, zero)
    getRed(&r, green: &g, blue: &b, alpha: &a)
    // round to 1 digit decimal
    let red   = round(r * 10) / 10
    let green = round(g * 10) / 10
    let blue  = round(b * 10) / 10
    return (red, green, blue)
  }
}
