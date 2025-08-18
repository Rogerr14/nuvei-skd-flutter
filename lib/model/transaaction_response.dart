import 'dart:convert';

import 'package:nuvei_sdk_flutter/model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/transaction_model.dart';

TransactionResponse transactionResponseFromJson(String str) => TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) => json.encode(data.toJson());

class TransactionResponse {
  TransactionModel transaction;
  CardModel card;
  ThreeDS? threeDS;

  TransactionResponse({
    required this.transaction,
    required this.card,
    this.threeDS,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      transaction: TransactionModel.fromJson(json['transaction'] as Map<String, dynamic>),
      card: CardModel.fromJson(json['card'] as Map<String, dynamic>),
      threeDS: json['3ds'] != null ? ThreeDS.fromJson(json['3ds'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'transaction': transaction.toJson(),
      'card': card.toJson(),
    };
    if (threeDS != null) data['3ds'] = threeDS!.toJson();
    return data;
  }
}



class ThreeDS {
  SdkResponse? sdkResponse;
  Authentication? authentication;
  BrowserResponse? browserResponse;

  ThreeDS({
    this.sdkResponse,
    this.authentication,
    this.browserResponse,
  });

  factory ThreeDS.fromJson(Map<String, dynamic> json) {
    return ThreeDS(
      sdkResponse: json['sdk_response'] != null
          ? SdkResponse.fromJson(json['sdk_response'] as Map<String, dynamic>)
          : null,
      authentication: json['authentication'] != null
          ? Authentication.fromJson(json['authentication'] as Map<String, dynamic>)
          : null,
      browserResponse: json['browser_response'] != null
          ? BrowserResponse.fromJson(json['browser_response'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (sdkResponse != null) data['sdk_response'] = sdkResponse!.toJson();
    if (authentication != null) data['authentication'] = authentication!.toJson();
    if (browserResponse != null) data['browser_response'] = browserResponse!.toJson();
    return data;
  }
}

class SdkResponse {
  String acsTransId;
  String? acsSignedContent;
  String acsReferenceNumber;

  SdkResponse({
    required this.acsTransId,
    this.acsSignedContent,
    required this.acsReferenceNumber,
  });

  factory SdkResponse.fromJson(Map<String, dynamic> json) {
    return SdkResponse(
      acsTransId: json['acs_trans_id'] as String,
      acsSignedContent: json['acs_signed_content'] as String?,
      acsReferenceNumber: json['acs_reference_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'acs_trans_id': acsTransId,
      'acs_reference_number': acsReferenceNumber,
    };
    if (acsSignedContent != null) data['acs_signed_content'] = acsSignedContent;
    return data;
  }
}

class Authentication {
  String status;
  String returnMessage;
  String? version;
  String xid;
  String referenceId;
  String? cavv;
  String returnCode;
  String? eci;

  Authentication({
    required this.status,
    required this.returnMessage,
    this.version,
    required this.xid,
    required this.referenceId,
    this.cavv,
    required this.returnCode,
    this.eci,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) {
    return Authentication(
      status: json['status'] as String,
      returnMessage: json['return_message'] as String,
      version: json['version'] as String?,
      xid: json['xid'] as String,
      referenceId: json['reference_id'] as String,
      cavv: json['cavv'] as String?,
      returnCode: json['return_code'] as String,
      eci: json['eci'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'status': status,
      'return_message': returnMessage,
      'xid': xid,
      'reference_id': referenceId,
      'return_code': returnCode,
    };
    if (version != null) data['version'] = version;
    if (cavv != null) data['cavv'] = cavv;
    if (eci != null) data['eci'] = eci;
    return data;
  }
}

class BrowserResponse {
  String hiddenIframe;
  String challengeRequest;

  BrowserResponse({
    required this.hiddenIframe,
    required this.challengeRequest,
  });

  factory BrowserResponse.fromJson(Map<String, dynamic> json) {
    return BrowserResponse(
      hiddenIframe: json['hidden_iframe'] as String,
      challengeRequest: json['challenge_request'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hidden_iframe': hiddenIframe,
      'challenge_request': challengeRequest,
    };
  }
}