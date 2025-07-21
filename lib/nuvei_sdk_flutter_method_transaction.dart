import 'dart:developer';

import 'package:nuvei_sdk_flutter/env/environment.dart';
import 'package:nuvei_sdk_flutter/model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/user_model.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter_transaction_interface.dart';
import 'package:nuvei_sdk_flutter/services/interceptor_http.dart';

class NuveiSdkFlutterMethodTransaction
    extends NuveiSdkFlutterTransactionInterface {
  InterceptorHttp interceptorHttp = InterceptorHttp();
  Environment env = Environment();

  @override
  void initEnvironment(
    String appCode,
    String appKey,
    String serverCode,
    String serverKey,
    bool testMode,
  ) {
    env.initConfig(
      appCode: appCode,
      appKey: appKey,
      serveCode: serverCode,
      serverKey: serverKey,
      testMode: testMode,
    );
  }

  @override
  Future<String> deleteCard() async {
    final urlEndpoint = '/v2/card/delete/';
    try {
      final response = await interceptorHttp.request(
        'POST',
        urlEndpoint,
        env.serverCode,
        env.serverCode,
        {
          "card": {"token": "090909"},
          "user": {"id": "4"},
        },
      );
      if (!response.error) {
        return response.data["message"];
      }
      return "Error to deleta a card";
    } catch (e) {
      return "Error on request, try again";
    }
  }

  @override
  Future<List<CardModel>?> listCards(String uid) async {
    final urlEndpoint = "/v2/card/list";
    try {
      final response = await interceptorHttp.request(
        'GET',
        urlEndpoint,
        env.serverCode,
        env.serverKey,
        null,
        queryParameters: {"uid": uid},
      );
      if (!response.error) {
        log('response');
        List<CardModel> listCards = List<CardModel>.from(
          response.data["cards"].map((x) => CardModel.fromJson(x)),
        );
        return listCards;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<CardModel?> addCard(CardModel card, UserModel user) async {
    final urlEndpoint = "/v2/card/add";
    try {
      final response = await interceptorHttp.request(
        'POST',
        urlEndpoint,
        env.appCode,
        env.appKey,
        {"user": user, "card": card, "extra_params": {}, "billing_address": {}},
      );
      if (!response.error) {
        CardModel card = response.data["card"];
        return card;
      }

      return null;
    } catch (e) {
      print('Error to add card;');
      return null;
    }
  }
}
