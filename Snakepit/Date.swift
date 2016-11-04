import Foundation

extension Date {
  public var prettyDate: String {
    return Date.prettyDatetestable(now: Date(), target: self)
  }

  static func prettyDatetestable(now: Date, target: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM dd, YYYY"
    let seconds = now.timeIntervalSince1970 - target.timeIntervalSince1970

    switch seconds {
    case ..<60:
      return "Just Now"
    case 60..<60*2:
      return "1 minute ago"
    case 60*2..<3600:
      return "\(Int(seconds/60)) minutes ago"
    case 3600..<3600*2:
      return "1 hour ago"
    case 3600*2..<86400:
      return "\(Int(seconds/3600)) hours ago"
    case 86400..<86400*2:
      return "1 day ago"
    case 86400*2..<604800:
      return "\(Int(seconds/86400)) days ago"
    default:
      return formatter.string(from: target)
    }
  }
}
