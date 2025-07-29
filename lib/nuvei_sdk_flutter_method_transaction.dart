import 'dart:convert';
import 'dart:developer';

import 'package:nuvei_sdk_flutter/env/environment.dart';
import 'package:nuvei_sdk_flutter/helper/global_helper.dart';
import 'package:nuvei_sdk_flutter/model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/error_model.dart';
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
  Future<dynamic> deleteCard({required String userId, required String tokenCard}) async {
    final urlEndpoint = '/v2/card/delete/';
    try {
      final response = await interceptorHttp.request(
        'POST',
        urlEndpoint,
        env.serverCode,
        env.serverKey,
        {
          "card": {"token": tokenCard},
          "user": {"id": userId},
        },
      );
      if (response is! ErrorResponseModel) {
        return response["message"];
      }
      return response;
    } catch (e) {
      return "Error on request, try again";
    }
  }

  @override
  Future<dynamic> listCards({required String userId}) async {
    final urlEndpoint = "/v2/card/list";
    try {
      final response = await interceptorHttp.request(
        'GET',
        urlEndpoint,
        env.serverCode,
        env.serverKey,
        null,
        queryParameters: {"uid": userId},
      );
      GlobalHelper.logger.w(response);
      if (response["error"] != null) {
        
        return response;
      }
      List<CardModel> cards = List<CardModel>.from(
        response["cards"].map((x) => CardModel.fromJson(x)),
      );
      return cards;
    } catch (e) {
      return ErrorResponseModel(
        error: Error(
          type: 'Exception',
          help: 'Exist an exeption $e',
          description: "",
        ),
      );
    }
  }

  @override
  Future<dynamic?> addCard(CardModel card, UserModel user) async {
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
