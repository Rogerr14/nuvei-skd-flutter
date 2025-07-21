import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'nuvei_sdk_flutter_method_channel.dart';

abstract class NuveiSdkFlutterPlatform extends PlatformInterface {
  /// Constructs a NuveiSdkFlutterPlatform.
  NuveiSdkFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static NuveiSdkFlutterPlatform _instance = MethodChannelNuveiSdkFlutter();

  /// The default instance of [NuveiSdkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelNuveiSdkFlutter].
  static NuveiSdkFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NuveiSdkFlutterPlatform] when
  /// they register themselves.
  static set instance(NuveiSdkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
