import 'package:flutter/material.dart';
import 'package:nuvei_sdk_flutter/model/card_model.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter.dart';
import 'package:nuvei_sdk_flutter_example/constanst/constants.dart';

class ListCardsPage extends StatefulWidget {
  const ListCardsPage({super.key});

  @override
  State<ListCardsPage> createState() => _ListCardsPageState();
}

class _ListCardsPageState extends State<ListCardsPage> {
  List<CardModel> cardModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCards();
  }

  void getCards() async {
    final response = await NuveiSdkFlutter().listCards(Constants.userId);
    if (response != null) {
      cardModel = response;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
