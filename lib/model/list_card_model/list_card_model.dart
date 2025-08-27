// To parse this JSON data, do
//
//     final listCardModel = listCardModelFromJson(jsonString);

import 'dart:convert';

import 'package:nuvei_sdk_flutter/model/list_card_model/card_item_model.dart';

ListCardModel listCardModelFromJson(String str) => ListCardModel.fromJson(json.decode(str));

String listCardModelToJson(ListCardModel data) => json.encode(data.toJson());

class ListCardModel {
    int resultSize;
    List<CardItemModel> cards;

    ListCardModel({
        required this.resultSize,
        required this.cards,
    });

    factory ListCardModel.fromJson(Map<String, dynamic> json) => ListCardModel(
        resultSize: json["result_size"],
        cards: List<CardItemModel>.from(json["cards"].map((x) => CardItemModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result_size": resultSize,
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
    };
}

