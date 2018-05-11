import UIKit

protocol WaterFallLayoutDelegate: class {
  func collectionView(_ collectionView: UICollectionView, heightForItemAt IndexPath: IndexPath) -> CGFloat
}

public class WaterFallLayout: UICollectionViewLayout {
  
  weak var delegate: WaterFallLayoutDelegate!
  
  public var numberOfColumns: Int = 2
  public var cellPadding: CGFloat = 8.0
  
  private var cache = [UICollectionViewLayoutAttributes]()
  private var contentHeight = CGFloat(0)
  
  public convenience init(columns: Int, cellPadding: CGFloat = 8.0) {
    self.init()
    self.numberOfColumns = columns
    self.cellPadding = cellPadding
  }
  
  private var contentWidth: CGFloat {
    guard let collectionView = collectionView else { return 0 }
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left + insets.right)
  }
  
  override public var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override public func prepare() {
    guard cache.isEmpty == true, let collectionView = collectionView else { return }
    
    let columnWidth = contentWidth / CGFloat(numberOfColumns)
    let xOffset = (0 ..< numberOfColumns).map { CGFloat($0) * columnWidth }
    
    var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
    
    for i in 0 ..< collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: i, section: 0)
      
      let photoHeight = delegate.collectionView(collectionView, heightForItemAt: indexPath)
      let height = cellPadding * 2 + photoHeight
      let column = i % numberOfColumns
      let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
      
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame
      cache.append(attributes)
      
      contentHeight = max(contentHeight, frame.maxY)
      yOffset[column] = yOffset[column] + height
    }
  }
  
  override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return cache.filter { $0.frame.intersects(rect) } // visible attributes
  }
  
  override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }
}
