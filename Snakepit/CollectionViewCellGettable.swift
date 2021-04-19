import UIKit

public protocol CollectionViewCellGettable {
  func register<T: UICollectionViewCell>(cell: T.Type)
  func deque<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T
  func deque<T: UICollectionReusableView>(header: T.Type, for indexPath: IndexPath) -> T
  func deque<T: UICollectionReusableView>(footer: T.Type, for indexPath: IndexPath) -> T
}

extension UICollectionView: CollectionViewCellGettable {
  public func register<T: UICollectionViewCell>(cell: T.Type) {
    guard let nib = cell.nib else {
      return register(cell, forCellWithReuseIdentifier: cell.reuseId)
    }
    register(nib, forCellWithReuseIdentifier: cell.reuseId)
  }

  public func deque<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: cell.reuseId, for: indexPath) as? T else {
      fatalError("dequeue collection view cell fail")
    }
    return cell
  }

  public func deque<T>(header: T.Type, for indexPath: IndexPath) -> T where T: UICollectionReusableView {
    guard let header = dequeueReusableSupplementaryView(
      ofKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: T.reuseId, for: indexPath) as? T else {
        fatalError("dequeue collection view header fail")
    }
    return header
  }

  public func deque<T>(footer: T.Type, for indexPath: IndexPath) -> T where T: UICollectionReusableView {
    guard let footer = dequeueReusableSupplementaryView(
      ofKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: T.reuseId, for: indexPath) as? T else {
        fatalError("dequeue collection view footer fail")
    }
    return footer
  }
}

extension UICollectionReusableView {
  static var reuseId: String {
    return String(describing: self)
  }

  static var nib: UINib? {
    let bundle = Bundle(for: self)
    guard bundle.path(forResource: reuseId, ofType: "nib") != nil else { return nil }
    return UINib(nibName: reuseId, bundle: bundle)
  }
}
