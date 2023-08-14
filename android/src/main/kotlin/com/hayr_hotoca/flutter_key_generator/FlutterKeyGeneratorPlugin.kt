package com.hayr_hotoca.flutter_key_generator

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey

/** FlutterKeyGeneratorPlugin */
class FlutterKeyGeneratorPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_key_generator")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "generateSymmetricKey") {
      generateSymmetricKey(call, result)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun generateSymmetricKey(call: MethodCall, result: Result) {
    try {
      val size = call.argument<Int>("size")
      if (size != 128 && size != 192 && size != 256) {
        return result.error(
        "Key size error",
        "Key size should be 128, 192 or 256.",
        null
        )
      }

      val keygen = KeyGenerator.getInstance("ChaCha20")
      keygen.init(size)
      val key: SecretKey = keygen.generateKey()

      result.success(key.encoded)
    } catch (e: Exception) {
      result.error("Generate symmetric key", e.localizedMessage, e)
    }
  }
}
