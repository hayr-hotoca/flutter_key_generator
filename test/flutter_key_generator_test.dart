import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_key_generator/flutter_key_generator.dart';
import 'package:flutter_key_generator/flutter_key_generator_platform_interface.dart';
import 'package:flutter_key_generator/flutter_key_generator_method_channel.dart';

class MockFlutterKeyGeneratorPlatform implements FlutterKeyGeneratorPlatform {
  @override
  Future<List<int>?> generateSymmetricKey(int size) => Future.value([42]);
}

void main() {
  final FlutterKeyGeneratorPlatform initialPlatform =
      FlutterKeyGeneratorPlatform.instance;

  test('$MethodChannelFlutterKeyGenerator is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterKeyGenerator>());
  });

  test('generateSymmetricKey', () async {
    expect(await FlutterKeyGenerator.generateSymmetricKey(256), [42]);
  });
}
