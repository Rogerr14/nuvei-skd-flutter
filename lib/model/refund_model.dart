// To parse this JSON data, do
//
//     final refundModel = refundModelFromJson(jsonString);

import 'dart:convert';

RefundModel refundModelFromJson(String str) => RefundModel.fromJson(json.decode(str));

String refundModelToJson(RefundModel data) => json.encode(data.toJson());

class RefundModel {
    Transaction transaction;
    Order? order;
    bool? moreInfo;

    RefundModel({
        required this.transaction,
        required this.order,
         this.moreInfo,
    });

    factory RefundModel.fromJson(Map<String, dynamic> json) => RefundModel(
        transaction: Transaction.fromJson(json["transaction"]),
        order: Order.fromJson(json["order"]),
        moreInfo: json["more_info"],
    );

    Map<String, dynamic> toJson() => {
        "transaction": transaction.toJson(),
        "order": order?.toJson(),
        "more_info": moreInfo,
    };
}

class Order {
    int? amount;

    Order({
         this.amount,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
    };
}

class Transaction {
    String id;
    double? referenceLabel;

    Transaction({
         this.id = '',
         this.referenceLabel,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        referenceLabel: json["reference_label"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "reference_label": referenceLabel,
    };
}
