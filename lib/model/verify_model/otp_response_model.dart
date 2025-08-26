import 'package:nuvei_sdk_flutter/model/add_card_model/card_response_model.dart';

class OtpResponse {
  final int? status;
  final DateTime? paymentDate;
  final double? amount;
  final String? transactionId;
  final int? statusDetail;
  final String? message;
  final TransactionOtpResponse? transaction;
  final CardOtpResponse? card;
  final ThreeDsResponse? threeDs;

  OtpResponse({
    this.status,
    this.paymentDate,
    this.amount,
    this.transactionId,
    this.statusDetail,
    this.message,
    this.transaction,
    this.card,
    this.threeDs,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
        status: json['status'],
        paymentDate: json['payment_date'] != null
            ? DateTime.tryParse(json['payment_date'])
            : null,
        amount: (json['amount'] as num?)?.toDouble(),
        transactionId: json['transaction_id'],
        statusDetail: json['status_detail'],
        message: json['message'],
        transaction: json['transaction'] != null
            ? TransactionOtpResponse.fromJson(json['transaction'])
            : null,
        card: json['card'] != null
            ? CardOtpResponse.fromJson(json['card'])
            : null,
        threeDs: json['3ds'] != null
            ? ThreeDsResponse.fromJson(json['3ds'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'payment_date': paymentDate?.toIso8601String(),
        'amount': amount,
        'transaction_id': transactionId,
        'status_detail': statusDetail,
        'message': message,
        'transaction': transaction?.toJson(),
        'card': card?.toJson(),
        '3ds': threeDs?.toJson(),
      };
}

class TransactionOtpResponse {
  final double amount;
  final String? authorizationCode;
  final String carrier;
  final String? carrierCode;
  final String? currentStatus;
  final String devReference;
  final String id;
  final int installments;
  final String installmentsType;
  final String? message;
  final String? paymentDate;
  final String paymentMethodType;
  final String productDescription;
  final String status;
  final int statusDetail;

  TransactionOtpResponse({
    required this.amount,
    this.authorizationCode,
    required this.carrier,
    this.carrierCode,
    this.currentStatus,
    required this.devReference,
    required this.id,
    required this.installments,
    required this.installmentsType,
    this.message,
    this.paymentDate,
    required this.paymentMethodType,
    required this.productDescription,
    required this.status,
    required this.statusDetail,
  });

  factory TransactionOtpResponse.fromJson(Map<String, dynamic> json) =>
      TransactionOtpResponse(
        amount: (json['amount'] as num).toDouble(),
        authorizationCode: json['authorization_code'],
        carrier: json['carrier'],
        carrierCode: json['carrier_code'],
        currentStatus: json['current_status'],
        devReference: json['dev_reference'],
        id: json['id'],
        installments: json['installments'],
        installmentsType: json['installments_type'],
        message: json['message'],
        paymentDate: json['payment_date'],
        paymentMethodType: json['payment_method_type'],
        productDescription: json['product_description'],
        status: json['status'],
        statusDetail: json['status_detail'],
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'authorization_code': authorizationCode,
        'carrier': carrier,
        'carrier_code': carrierCode,
        'current_status': currentStatus,
        'dev_reference': devReference,
        'id': id,
        'installments': installments,
        'installments_type': installmentsType,
        'message': message,
        'payment_date': paymentDate,
        'payment_method_type': paymentMethodType,
        'product_description': productDescription,
        'status': status,
        'status_detail': statusDetail,
      };
}



class SDKResponse {
  final String acsTransId;
  final String? acsSignedContent;
  final String acsReferenceNumber;

  SDKResponse({
    required this.acsTransId,
    this.acsSignedContent,
    required this.acsReferenceNumber,
  });

  factory SDKResponse.fromJson(Map<String, dynamic> json) => SDKResponse(
        acsTransId: json['acs_trans_id'],
        acsSignedContent: json['acs_signed_content'],
        acsReferenceNumber: json['acs_reference_number'],
      );

  Map<String, dynamic> toJson() => {
        'acs_trans_id': acsTransId,
        'acs_signed_content': acsSignedContent,
        'acs_reference_number': acsReferenceNumber,
      };
}

class Authentication3ds {
  final String status;
  final String returnMessage;
  final String? version;
  final String xid;
  final String referenceId;
  final String? cavv;
  final String returnCode;
  final String? eci;

  Authentication3ds({
    required this.status,
    required this.returnMessage,
    this.version,
    required this.xid,
    required this.referenceId,
    this.cavv,
    required this.returnCode,
    this.eci,
  });

  factory Authentication3ds.fromJson(Map<String, dynamic> json) =>
      Authentication3ds(
        status: json['status'],
        returnMessage: json['return_message'],
        version: json['version'],
        xid: json['xid'],
        referenceId: json['reference_id'],
        cavv: json['cavv'],
        returnCode: json['return_code'],
        eci: json['eci'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'return_message': returnMessage,
        'version': version,
        'xid': xid,
        'reference_id': referenceId,
        'cavv': cavv,
        'return_code': returnCode,
        'eci': eci,
      };
}

class ThreeDsResponse {
  final SDKResponse sdkResponse;
  final Authentication3ds authentication;
  final BrowserResponse browserResponse;

  ThreeDsResponse({
    required this.sdkResponse,
    required this.authentication,
    required this.browserResponse,
  });

  factory ThreeDsResponse.fromJson(Map<String, dynamic> json) => ThreeDsResponse(
        sdkResponse: SDKResponse.fromJson(json['sdk_response']),
        authentication: Authentication3ds.fromJson(json['authentication']),
        browserResponse: BrowserResponse.fromJson(json['browser_response']),
      );

  Map<String, dynamic> toJson() => {
        'sdk_response': sdkResponse.toJson(),
        'authentication': authentication.toJson(),
        'browser_response': browserResponse.toJson(),
      };
}

class CardOtpResponse {
  final String bin;
  final String status;
  final String token;
  final String expiryYear;
  final String expiryMonth;
  final String transactionReference;
  final String type;
  final String number;
  final String origin;

  CardOtpResponse({
    required this.bin,
    required this.status,
    required this.token,
    required this.expiryYear,
    required this.expiryMonth,
    required this.transactionReference,
    required this.type,
    required this.number,
    required this.origin,
  });

  factory CardOtpResponse.fromJson(Map<String, dynamic> json) => CardOtpResponse(
        bin: json['bin'],
        status: json['status'],
        token: json['token'],
        expiryYear: json['expiry_year'],
        expiryMonth: json['expiry_month'],
        transactionReference: json['transaction_reference'],
        type: json['type'],
        number: json['number'],
        origin: json['origin'],
      );

  Map<String, dynamic> toJson() => {
        'bin': bin,
        'status': status,
        'token': token,
        'expiry_year': expiryYear,
        'expiry_month': expiryMonth,
        'transaction_reference': transactionReference,
        'type': type,
        'number': number,
        'origin': origin,
      };
}
