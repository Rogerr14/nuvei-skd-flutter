import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nuvei_sdk_flutter/model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/error_model.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter.dart';
import 'package:nuvei_sdk_flutter/widget/filled_button_widget.dart';
import 'package:nuvei_sdk_flutter_example/constanst/constants.dart';
import 'package:nuvei_sdk_flutter_example/environments/theme_config.dart';

class ListCardsPage extends StatefulWidget {
  CardModel? cardModel;
  ListCardsPage({super.key, this.cardModel});

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
    final response = await NuveiSdkFlutter().listCards(
      userId: Constants.userId,
    );
    if (response is! ErrorResponseModel) {
      // log(jsonEncode(response));
      cardModel = response;
      setState(() {
        log("si");
      });
    }
  }

  void deleteCard(String tokenCard) async {
    final response = await NuveiSdkFlutter().deleteCard(
      tokenCard: tokenCard,
      userId: Constants.userId,
    );
    if (response is! ErrorResponseModel) {
      showDialog(
        context: context,
        builder:
            (context) => Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(response, style: TextStyle(fontSize: 20)),
                          FilledButtonWidget(
                            text: "Close",
                            onPressed: () async {
                              getCards();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [],
        leading: Container(),
        centerTitle: true,
        title: Image.asset(ThemeConfig().logoImagePath, width: 100),
      ),
      body: Column(
        children: [
          Text("List of Cards"),
          SizedBox(
            height: size.height * 0.7,
            // width: size.width * 0.9,
            child: ListView.builder(
              itemCount: cardModel.length,

              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        CardModel cardModelSelect = cardModel[index];
                        Navigator.pop(context, cardModelSelect);
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  ThemeConfig().logoImagePath,
                                  width: 50,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cardModel[index].holderName ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "---- ---- ---- ${cardModel[index].number ?? ''}",
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  deleteCard(cardModel[index].token ?? '');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
