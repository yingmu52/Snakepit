import JavaScriptCore

public protocol JavaScriptRunnable {
  var bundle: Bundle { get }
}

extension JavaScriptRunnable where Self: RawRepresentable, Self.RawValue == String {
  public func run(args: [Any] = []) -> JSValue? {
    guard let fileURL = bundle.url(forResource: rawValue, withExtension: "js"),
      let jsSource = try? String(contentsOf: fileURL, encoding: .utf8),
      let context = JSContext() else { return nil }
    context.evaluateScript(jsSource)
    return context.objectForKeyedSubscript(rawValue).call(withArguments: args)
  }
}
