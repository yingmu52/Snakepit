import Snakepit
import Foundation

enum JSFunc: String, JavaScriptRunnable {
  case hello
  var bundle: Bundle {
    return Bundle(for: Test.self)
  }
}
  
print(JSFunc.hello.run())
