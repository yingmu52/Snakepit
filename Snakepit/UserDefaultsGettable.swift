import Foundation

public protocol UserDefaultsGettable {
  static var bundle: Bundle { get }
  func get<T>(_ type: T.Type) -> T?
  func set(_ value: Any?)
}

public extension UserDefaultsGettable where Self: RawRepresentable {
  var key: String {
    return String(describing: Self.bundle.bundleIdentifier) + String(describing: RawValue.self)
  }
  func get<T>(_ type: T.Type) -> T? {
    return UserDefaults.standard.object(forKey: key) as? T
  }
  func set(_ value: Any?) {
    UserDefaults.standard.set(value, forKey: key)
  }
  func remove() {
    UserDefaults.standard.removeObject(forKey: key)
  }
}
