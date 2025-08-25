// To parse this JSON data, do
//
//     final cardItemModel = cardItemModelFromJson(jsonString);

import 'dart:convert';

CardItemModel cardItemModelFromJson(String str) => CardItemModel.fromJson(json.decode(str));

String cardItemModelToJson(CardItemModel data) => json.encode(data.toJson());

class CardItemModel {
    String? bin;
    String? status;
    String? token;
    String? holderName;
    String? expiryYear;
    String? expiryMonth;
    String? transactionReference;
    String? type;
    String? number;

    CardItemModel({
        this.bin,
        this.status,
        this.token,
        this.holderName,
        this.expiryYear,
        this.expiryMonth,
        this.transactionReference,
        this.type,
        this.number,
    });

    factory CardItemModel.fromJson(Map<String, dynamic> json) => CardItemModel(
        bin: json["bin"],
        status: json["status"],
        token: json["token"],
        holderName: json["holder_name"],
        expiryYear: json["expiry_year"],
        expiryMonth: json["expiry_month"],
        transactionReference: json["transaction_reference"],
        type: json["type"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "bin": bin,
        "status": status,
        "token": token,
        "holder_name": holderName,
        "expiry_year": expiryYear,
        "expiry_month": expiryMonth,
        "transaction_reference": transactionReference,
        "type": type,
        "number": number,
    };
}
