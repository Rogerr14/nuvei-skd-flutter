// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

import 'package:nuvei_sdk_flutter/env/environment.dart';
import 'package:nuvei_sdk_flutter/model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/user_model.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter_method_transaction.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter_transaction_interface.dart';

import 'nuvei_sdk_flutter_platform_interface.dart';

class NuveiSdkFlutter {
  Future<String?> getPlatformVersion() {
    return NuveiSdkFlutterPlatform.instance.getPlatformVersion();
  }

  static final NuveiSdkFlutter _nuveiSdkFlutter = NuveiSdkFlutter._internal();

  factory NuveiSdkFlutter() => _nuveiSdkFlutter;

  NuveiSdkFlutter._internal();

  Future<String?> deleteCard() async {
    return NuveiSdkFlutterTransactionInterface.instance.deleteCard();
  }

  Future<List<CardModel>?> listCards(String uid) async {
    return NuveiSdkFlutterTransactionInterface.instance.listCards(uid);
  }

  Future<CardModel?> addCard(CardModel card, UserModel user) async {
    return NuveiSdkFlutterTransactionInterface.instance.addCard(card, user);
  }

  void initEnvironment(
    String appCode,
    String appKey,
    String serverCode,
    String serverKey,
    bool testMode,
  ) {
    return NuveiSdkFlutterTransactionInterface.instance.initEnvironment(
      appCode,
      appKey,
      serverCode,
      serverKey,
      testMode,
    );
  }
}
