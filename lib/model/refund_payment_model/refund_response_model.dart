// To parse this JSON data, do
//
//     final refundResponseModel = refundResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:nuvei_sdk_flutter/model/transaction_model.dart';

RefundResponseModel refundResponseModelFromJson(String str) => RefundResponseModel.fromJson(json.decode(str));

String refundResponseModelToJson(RefundResponseModel data) => json.encode(data.toJson());

class RefundResponseModel {
    String? status;
    TransactionModel? transaction;
    String? detail;
    CardData? card;

    RefundResponseModel({
        this.status,
        this.transaction,
        this.detail,
        this.card,
    });

    factory RefundResponseModel.fromJson(Map<String, dynamic> json) => RefundResponseModel(
        status: json["status"],
        transaction: json["transaction"] == null ? null : TransactionModel.fromJson(json["transaction"]),
        detail: json["detail"],
        card: json["card"] == null ? null : CardData.fromJson(json["card"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "transaction": transaction?.toJson(),
        "detail": detail,
        "card": card?.toJson(),
    };
}

class CardData {
    String? bin;
    String? status;
    String? token;
    String? expiryYear;
    String? expiryMonth;
    String? transactionReference;
    String? type;
    String? number;
    String? origin;

    CardData({
        this.bin,
        this.status,
        this.token,
        this.expiryYear,
        this.expiryMonth,
        this.transactionReference,
        this.type,
        this.number,
        this.origin,
    });

    factory CardData.fromJson(Map<String, dynamic> json) => CardData(
        bin: json["bin"],
        status: json["status"],
        token: json["token"],
        expiryYear: json["expiry_year"],
        expiryMonth: json["expiry_month"],
        transactionReference: json["transaction_reference"],
        type: json["type"],
        number: json["number"],
        origin: json["origin"],
    );

    Map<String, dynamic> toJson() => {
        "bin": bin,
        "status": status,
        "token": token,
        "expiry_year": expiryYear,
        "expiry_month": expiryMonth,
        "transaction_reference": transactionReference,
        "type": type,
        "number": number,
        "origin": origin,
    };
}
