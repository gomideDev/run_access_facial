import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:run_access_facial/run_access_facial.dart';

void main() {
  const MethodChannel channel = MethodChannel('run_access_facial');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await RunAccessFacial.platformVersion, '42');
  });
}
