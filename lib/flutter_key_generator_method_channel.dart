import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_key_generator_platform_interface.dart';

/// An implementation of [FlutterKeyGeneratorPlatform] that uses method channels.
class MethodChannelFlutterKeyGenerator extends FlutterKeyGeneratorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_key_generator');

  @override
  Future<List<int>?> generateSymmetricKey(int size) async {
    final version = await methodChannel.invokeMethod<List<int>>('generateSymmetricKey', { 'size': size });
    return version;
  }
}
