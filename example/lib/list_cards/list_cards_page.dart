import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nuvei_sdk_flutter/model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/error_model.dart';
import 'package:nuvei_sdk_flutter/model/list_card_model.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter.dart';
import 'package:nuvei_sdk_flutter/widget/filled_button_widget.dart';
import 'package:nuvei_sdk_flutter_example/add_card/add_card_page.dart';
import 'package:nuvei_sdk_flutter_example/constanst/constants.dart';
import 'package:nuvei_sdk_flutter_example/environments/theme_config.dart';

class ListCardsPage extends StatefulWidget {
  CardModel? cardModel;
  ListCardsPage({super.key, this.cardModel});

  @override
  State<ListCardsPage> createState() => _ListCardsPageState();
}

class _ListCardsPageState extends State<ListCardsPage> {
  List<CardModel> listCardsAvaliable = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

    getCards();
    });
  }

  void getCards() async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    final response = await NuveiSdkFlutter().listCards(
      userId: Constants.userId,
    );
    Navigator.pop(context);
    log("------------");
    log(jsonEncode(response));

    if (!response.error) {
      ListCardModel listCards = listCardModelFromJson(
        jsonEncode(response.data),
      );
      listCardsAvaliable = listCards.cards;
      setState(() {});
    }
  }

  void deleteCard(String tokenCard) async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    final response = await NuveiSdkFlutter().deleteCard(
      tokenCard: tokenCard,
      userId: Constants.userId,
    );
    Navigator.pop(context);
    if (!response.error) {
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
                          Text(response.data, style: TextStyle(fontSize: 20)),
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
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("List of Cards"),
            SizedBox(
              height: size.height * 0.7,
              // width: size.width * 0.9,
              child:( listCardsAvaliable.isEmpty)? 
              
                Text('No cards avaliable')
              : ListView.builder(
                itemCount: listCardsAvaliable.length,
        
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          CardModel cardModelSelect = listCardsAvaliable[index];
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
                                        listCardsAvaliable[index].holderName ??
                                            '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "---- ---- ---- ${listCardsAvaliable[index].number ?? ''}",
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
                                    deleteCard(
                                      listCardsAvaliable[index].token ?? '',
                                    );
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
            FilledButtonWidget(
              text: 'Add a new Card',
              onPressed: () => Navigator.pushNamed(context, "add_card"),
            ),
          ],
        ),
      ),
    );
  }
}
