import 'flutter_key_generator_method_channel.dart';

abstract class FlutterKeyGeneratorPlatform {
  static FlutterKeyGeneratorPlatform instance =
      MethodChannelFlutterKeyGenerator();

  Future<List<int>?> generateSymmetricKey(int size) {
    throw UnimplementedError(
        'generateSymmetricKey() has not been implemented.');
  }
}
