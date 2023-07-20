
import 'flutter_key_generator_platform_interface.dart';

class FlutterKeyGenerator {
 /// size should 128, 192 or 256 (bit key)
  static Future<List<int>?> generateSymmetricKey(int size) {
    /// this will call to native platform
    return FlutterKeyGeneratorPlatform.instance.generateSymmetricKey(size);
  }
}
