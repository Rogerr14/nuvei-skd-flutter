// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
    String? number;
    String? bin;
    String? type;
    String? transactionReference;
    String? status;
    String? token;
    dynamic expiryYear;
    dynamic expiryMonth;
    String? origin;
    String? bankName;
    String? message;
    String? cvc;
    String? holderName;
    String? last4;

    CardModel({
         this.number,
         this.bin,
         this.type,
         this.transactionReference,
         this.status,
         this.token,
         this.expiryYear,
         this.expiryMonth,
         this.origin,
         this.bankName,
         this.message,
         this.cvc,
         this.holderName,
         this.last4,
    });

    factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        number: json["number"],
        bin: json["bin"],
        type: json["type"],
        transactionReference: json["transaction_reference"],
        status: json["status"],
        token: json["token"],
        expiryYear: json["expiry_year"],
        expiryMonth: json["expiry_month"],
        origin: json["origin"],
        bankName: json["bank_name"],
        message: json["message"],
        cvc: json["cvc"],
        holderName: json["holder_name"],
        last4: json["last4"],
    );

   Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = {};

  if (number != null) {
    data['number'] = number;
  }
  if (expiryYear != null) {
    data['expiry_year'] = expiryYear;
  }
  if (expiryMonth != null) {
    data['expiry_month'] = expiryMonth;
  }
  if (type != null) {
    data['type'] = type;
  }
  if (last4 != null) {
    data['last4'] = last4;
  }
  if (token != null) {
    data['token'] = token;
  }
  if (bin != null) {
    data['bin'] = bin;
  }
  if (transactionReference != null) {
    data['transaction_reference'] = transactionReference;
  }
  if (status != null) {
    data['status'] = status;
  }
  if (origin != null) {
    data['origin'] = origin;
  }
  if (bankName != null) {
    data['bank_name'] = bankName;
  }
  if (cvc != null) {
    data['cvc'] = cvc;
  }
  if (holderName != null) {
    data['holder_name'] = holderName;
  }

  return data;
}
}
