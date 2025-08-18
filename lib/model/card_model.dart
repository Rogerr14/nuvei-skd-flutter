import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  String? bin;
  String? status;
  String? token;
  String? expiryYear;
  String? expiryMonth;
  String? transactionReference;
  String? type;
  String? number;
  String? origin;
  String? holderName;
  String? message;
  String? cvc;

  CardModel({
    this.bin,
    this.status,
    this.token,
    this.expiryYear,
    this.expiryMonth,
    this.transactionReference,
    this.type,
    this.number,
    this.origin,
    this.holderName,
    this.message,
    this.cvc,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      bin: json['bin'] as String?,
      status: json['status'] as String?,
      token: json['token'] as String?,
      expiryYear: json['expiry_year'] as String?,
      expiryMonth: json['expiry_month'] as String?,
      transactionReference: json['transaction_reference'] as String?,
      type: json['type'] as String?,
      number: json['number'] as String?,
      origin: json['origin'] as String?,
      holderName: json['holder_name'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (bin != null) data['bin'] = bin;
    if (status != null) data['status'] = status;
    if (token != null) data['token'] = token;
    if (expiryYear != null) data['expires_year'] = expiryYear;
    if (expiryMonth != null) data['expires_month'] = expiryMonth;
    if (transactionReference != null) {
      data['transaction_reference'] = transactionReference;
    }
    if (cvc != null) data["cvc"] = cvc;
    if (type != null) data['type'] = type;
    if (number != null) data['number'] = number;
    if (origin != null) data['origin'] = origin;
    if (holderName != null) data['holder_name'] = holderName;
    if (message != null) data['message'] = message;
    return data;
  }
}
