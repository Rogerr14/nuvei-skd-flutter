import 'package:flutter_test/flutter_test.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter_platform_interface.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNuveiSdkFlutterPlatform
    with MockPlatformInterfaceMixin
    implements NuveiSdkFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NuveiSdkFlutterPlatform initialPlatform = NuveiSdkFlutterPlatform.instance;

  test('$MethodChannelNuveiSdkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNuveiSdkFlutter>());
  });

  test('getPlatformVersion', () async {
    NuveiSdkFlutter nuveiSdkFlutterPlugin = NuveiSdkFlutter();
    MockNuveiSdkFlutterPlatform fakePlatform = MockNuveiSdkFlutterPlatform();
    NuveiSdkFlutterPlatform.instance = fakePlatform;

    // expect(await nuveiSdkFlutterPlugin.getPlatformVersion(), '42');
  });
}
