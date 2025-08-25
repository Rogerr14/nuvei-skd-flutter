// To parse this JSON data, do
//
//     final refundModel = refundModelFromJson(jsonString);

import 'dart:convert';

import 'package:nuvei_sdk_flutter/model/order_model.dart';
import 'package:nuvei_sdk_flutter/model/transaction_model.dart';

RefundModel refundModelFromJson(String str) => RefundModel.fromJson(json.decode(str));

String refundModelToJson(RefundModel data) => json.encode(data.toJson());

class RefundModel {
    TransactionModel transaction;
    Order? order;
    bool? moreInfo;

    RefundModel({
        required this.transaction,
        required this.order,
         this.moreInfo,
    });

    factory RefundModel.fromJson(Map<String, dynamic> json) => RefundModel(
        transaction: TransactionModel.fromJson(json["transaction"]),
        order: Order.fromJson(json["order"]),
        moreInfo: json["more_info"],
    );

    Map<String, dynamic> toJson() => {
        "transaction": transaction.toJson(),
        "order": order?.toJson(),
        "more_info": moreInfo,
    };
}



