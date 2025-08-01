import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'nuvei_sdk_flutter_platform_interface.dart';

/// An implementation of [NuveiSdkFlutterPlatform] that uses method channels.
class MethodChannelNuveiSdkFlutter extends NuveiSdkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('nuvei_sdk_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
