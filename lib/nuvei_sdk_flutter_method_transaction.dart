import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuvei_sdk_flutter/env/environment.dart';
import 'package:nuvei_sdk_flutter/helper/global_helper.dart';
import 'package:nuvei_sdk_flutter/model/add_card_model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/add_card_model/extra_params_model.dart';
import 'package:nuvei_sdk_flutter/model/list_card_model/card_item_model.dart';
import 'package:nuvei_sdk_flutter/model/order_model.dart';
import 'package:nuvei_sdk_flutter/model/payment_model/debit_model.dart';
import 'package:nuvei_sdk_flutter/model/error_model.dart';
import 'package:nuvei_sdk_flutter/model/general_response.dart';
import 'package:nuvei_sdk_flutter/model/list_card_model/list_card_model.dart';
import 'package:nuvei_sdk_flutter/model/refund_payment_model/refund_model.dart';
import 'package:nuvei_sdk_flutter/model/refund_payment_model/refund_response_model.dart';
import 'package:nuvei_sdk_flutter/model/transaaction_response.dart';
import 'package:nuvei_sdk_flutter/model/transaction_model.dart';
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
  Future<GeneralResponse> deleteCard({
    required String userId,
    required String tokenCard,
  }) async {
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
      if (!response.error) {
        String message = response.data["message"];
        return GeneralResponse(error: false, data: message);
      }
      return response;
    } catch (e) {
      return GeneralResponse(error: true);
    }
  }

  @override
  Future<GeneralResponse> listCards({required String userId}) async {
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
      GlobalHelper.logger.w("aqui llego esto : ${jsonEncode(response)}");
      if (!response.error) {
        ListCardModel listCards = listCardModelFromJson(
          jsonEncode(response.data),
        );

        log(jsonEncode(listCards));
        return GeneralResponse(error: false, data: listCards);
      }
      return response;
    } catch (e) {
      return GeneralResponse(error: true, data: null);
    }
  }

  @override
  Future<GeneralResponse> addCard(CardModel card, UserModel user, BuildContext context) async {
    final urlEndpoint = "/v2/card/add";
    try {

      final extraParams = ExtraParamsModel(

        
      );

      GlobalHelper().getBrowserInfo(context);



      final data = {
          "user": user,
           "card": card, 
          "extra_params" : ''
      };




      final response = await interceptorHttp.request(
        'POST',
        urlEndpoint,
        env.appCode,
        env.appKey,
        {"extra_params": {},},
      );

      if (!response.error) {
        CardItemModel card = cardItemModelFromJson(jsonEncode(response.data));
        return GeneralResponse(error: false, data: card);
      }

      return response;
    } catch (e) {
      return GeneralResponse(error: true, data: null);
    }
  }

  @override
  Future<GeneralResponse> debit({
    required User userInformation,
    required Order ordeInformation,
    required CardModel cardInformation,
  }) async {
    final urlEndpoint = '/v2/transaction/debit/';
    try {
      CreditCardTransaction transaction = CreditCardTransaction(
        order: ordeInformation,
        user: userInformation,
        card: cardInformation,
      );
      final response = await interceptorHttp.request(
        'POST',
        urlEndpoint,
        env.serverCode,
        env.serverKey,
        transaction,
      );
      if (!response.error) {
        TransactionResponse data = transactionResponseFromJson(
          jsonEncode(response.data),
        );
        return GeneralResponse(error: false, data: data);
      }
      return response;
    } catch (e) {
      return GeneralResponse(error: true, data: null);
    }
  }

  @override
  Future<GeneralResponse> refund({
    required TransactionModel transaction,
    Order? order,
    bool moreInfo = true,
  }) async {
    try {
      final urlEndpoint = '/v2/transaction/refund/';
      RefundModel refundBody = RefundModel(
        transaction: transaction,
        order: order,
        moreInfo: moreInfo,
      );
      final response = await interceptorHttp.request(
        'POST',
        urlEndpoint,
        env.serverCode,
        env.serverKey,
        refundBody,
      );
 if (!response.error) {
        RefundResponseModel data = refundResponseModelFromJson(
          jsonEncode(response.data),
        );
        return GeneralResponse(error: false, data: data);
      }
      return response;

    } catch (e) {
      return GeneralResponse(error: true, data: null);
    }
  }
}
