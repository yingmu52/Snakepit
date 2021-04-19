import UIKit

public class BlockchainLayout: UICollectionViewFlowLayout {
  
  public convenience init(
    itemSize: CGSize,
    direction: UICollectionView.ScrollDirection = .horizontal,
    pageMargin: CGFloat = 0.0) {
    self.init()
    self.itemSize = itemSize
    self.scrollDirection = direction
    self.minimumLineSpacing = pageMargin
  }
}

extension BlockchainLayout {
  override public func prepare() {
    guard let collectionView = collectionView else { return }
    collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    let collectionSize = collectionView.bounds.size
    let y = (collectionSize.height - itemSize.height) / 2
    let x = (collectionSize.width - itemSize.width) / 2
    sectionInset = UIEdgeInsets(top: y, left: x, bottom: y, right: x)
  }
  
  override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                           withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard
      let collectionView = collectionView ,
      !collectionView.isPagingEnabled,
      let layoutAttributes = layoutAttributesForElements(in: collectionView.bounds)
      else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }
    
    let isHorizontal = (scrollDirection == .horizontal)
    let midSide = (isHorizontal ? collectionView.bounds.size.width : collectionView.bounds.size.height) / 2
    let p = (isHorizontal ? proposedContentOffset.x : proposedContentOffset.y) + midSide
    
    if isHorizontal {
      let closest = layoutAttributes
        .sorted { abs($0.center.x - p) < abs($1.center.x - p) }
        .first ?? UICollectionViewLayoutAttributes()
      return CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
    } else {
      let closest = layoutAttributes
        .sorted { abs($0.center.y - p) < abs($1.center.y - p) }
        .first ?? UICollectionViewLayoutAttributes()
      return CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - midSide))
    }
  }
  
  override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}
