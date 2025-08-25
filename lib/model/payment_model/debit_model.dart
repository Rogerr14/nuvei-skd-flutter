import 'package:nuvei_sdk_flutter/model/add_card_model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/order_model.dart';

class CreditCardTransaction {
  String? sessionId;
  Order order;
  User user;
  CardModel? card;
  Wallet? wallet;
  Map<String, dynamic>? extraParams;
  Map<String, dynamic>? shippingAddress;
  Map<String, dynamic>? airline;
  Map<String, dynamic>? hotel;

  CreditCardTransaction({
    this.sessionId,
    required this.order,
    required this.user,
    this.card,
    this.wallet,
    this.extraParams,
    this.shippingAddress,
    this.airline,
    this.hotel,
  });

  factory CreditCardTransaction.fromJson(Map<String, dynamic> json) {
    return CreditCardTransaction(
      sessionId: json['session_id'] as String?,
      order: Order.fromJson(json['order'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      card: json['card'] != null ? CardModel.fromJson(json['card'] as Map<String, dynamic>) : null,
      wallet: json['wallet'] != null ? Wallet.fromJson(json['wallet'] as Map<String, dynamic>) : null,
      extraParams: json['extra_params'] as Map<String, dynamic>?,
      shippingAddress: json['shipping_address'] as Map<String, dynamic>?,
      airline: json['airline'] as Map<String, dynamic>?,
      hotel: json['hotel'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'order': order.toJson(),
      'user': user.toJson(),
    };
    if (sessionId != null) data['session_id'] = sessionId;
    if (card != null) data['card'] = card!.toJson();
    if (wallet != null) data['wallet'] = wallet!.toJson();
    if (extraParams != null) data['extra_params'] = extraParams;
    if (shippingAddress != null) data['shipping_address'] = shippingAddress;
    if (airline != null) data['airline'] = airline;
    if (hotel != null) data['hotel'] = hotel;
    return data;
  }
}

class User {
  String id;
  String? firstName;
  String? lastName;
  String email;
  String? phone;
  String? ipAddress;
  String? fiscalNumber;

  User({
    required this.id,
    this.firstName,
    this.lastName,
    required this.email,
    this.phone,
    this.ipAddress,
    this.fiscalNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      ipAddress: json['ip_address'] as String?,
      fiscalNumber: json['fiscal_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'email': email,
    };
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (phone != null) data['phone'] = phone;
    if (ipAddress != null) data['ip_address'] = ipAddress;
    if (fiscalNumber != null) data['fiscal_number'] = fiscalNumber;
    return data;
  }
}

class Wallet {
  String type;
  String key;

  Wallet({
    required this.type,
    required this.key,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      type: json['type'] as String,
      key: json['key'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'key': key,
    };
  }
}