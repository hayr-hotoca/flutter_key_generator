import Flutter
import UIKit
import CryptoKit

public class FlutterKeyGeneratorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_key_generator", binaryMessenger: registrar.messenger())
    let instance = FlutterKeyGeneratorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      guard let args = call.arguments as? [String: Any] else {
          result(FlutterError(
              code: "CAUGHT_ERROR",
              message:"Invalid arguments",
              details: nil))
          return
      }

      do {
          switch call.method {
            case "generateSymmetricKey":
              try self.generateSymmetricKey(args: args, result: result)
            default:
              result(FlutterMethodNotImplemented)
            }
      } catch let error as NSError {
          result(FlutterError(
              code: "CAUGHT_ERROR",
              message:"\(error.domain), \(error.code), \(error.description)",
              details: nil))
      } catch {
          result(FlutterError(
              code: "CAUGHT_ERROR",
              message:"\(error)",
              details: nil))
      }
  }
    
    private func generateSymmetricKey(args: [String: Any], result: @escaping FlutterResult)  throws {
        if #available(iOS 13.0, *) {
            guard let size = args["size"] as? Int else {
                result(parameterError(name: "size"))
                return
            }

            var newKey = SymmetricKey.init(size: SymmetricKeySize.bits256)
            switch size {
              case 128 :
                newKey = SymmetricKey.init(size: SymmetricKeySize.bits128)
              case 192:
                newKey = SymmetricKey.init(size: SymmetricKeySize.bits192)
              case 256:
                newKey = SymmetricKey.init(size: SymmetricKeySize.bits256)
              default:
                result(FlutterError(code: "Key size error", message: "Key size should be 128, 192 or 256", details: nil))
                return
            }

            let key = newKey.withUnsafeBytes {
                return Data(Array($0))
            }
            
            result(FlutterStandardTypedData(bytes: key))
        }
        result(FlutterError(code: "UNSUPPORTED_ALGORITHM", message:nil, details: nil))
    }
    
    private func parameterError(name: String) -> FlutterError {
        return FlutterError(code: "INVALID_ARGUMENT", message: "Parameter '\(name)' is missing or invalid", details: nil)
    }
}
