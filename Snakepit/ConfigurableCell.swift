import Foundation
import UIKit

public protocol ConfigurableCell: class {
  associatedtype Value
  static var reuseID: String { get }
  func configure(with value: Value)
}

extension ConfigurableCell where Self: UITableViewCell {
  public static var reuseID: String { return reuseId }
}
extension ConfigurableCell where Self: UICollectionViewCell {
  public static var reuseID: String { return reuseId }
}
