import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nuvei_sdk_flutter/helper/global_helper.dart';
import 'package:nuvei_sdk_flutter/model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/debit_model.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter.dart';
import 'package:nuvei_sdk_flutter/widget/filled_button_widget.dart';
import 'package:nuvei_sdk_flutter_example/constanst/constants.dart';
import 'package:nuvei_sdk_flutter_example/environments/theme_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CardModel? cardModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NuveiSdkFlutter nuvei = NuveiSdkFlutter();
    nuvei.initEnvironment(
      Constants.appCode,
      Constants.appKey,
      Constants.serverCode,
      Constants.serverKey,
      true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (didPop, result) => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(ThemeConfig().logoImagePath, width: size.width * 0.2),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.03,
           
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width,
                child: DataTable(
                  showBottomBorder: true,
                  columns: [
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Price')),
                  ],
                  rows: [
                    DataRow(
                      cells: [ DataCell(Row(
                          children: [
                            Icon(Icons.shopping_bag_rounded),
                            Text("2"),
                          ],
                        )),
                        DataCell(Text("Milk Shake")),
                        DataCell(Text("\$13.90")),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Row(
                          children: [
                            Icon(Icons.shopping_bag_rounded),
                            Text("2"),
                          ],
                        )),
                        DataCell(Text("Milk Shake")),
                        DataCell(Text("\$13.90")),
                      ],
                    ),
                    DataRow(
                      cells: [
                         DataCell(Row(
                          children: [
                            Icon(Icons.shopping_bag_rounded),
                            Text("2"),
                          ],
                        )),
                        DataCell(Text("Milk Shake")),
                        DataCell(Text("\$13.90")),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.15,
                    width: size.width * 0.8,
                    child: Card(
                      child: InkWell(
                        onTap: () async {
                          var result = await Navigator.pushNamed(
                            context,
                            "list_card",
                            arguments: cardModel,
                          );
                          if (result != null) {
                            cardModel = result as CardModel?;

                            setState(() {});
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child:
                              (cardModel == null)
                                  ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "No Card Selected",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("Need to select a card to continue"),
                                    ],
                                  )
                                  : Column(
                                    children: [
                                      Text(cardModel?.holderName ?? ''),
                                      Text(
                                        '---- ---- ---- ${cardModel?.number ?? ''}',
                                      ),
                                      Text("cvc ${cardModel?.cvc ?? ''}"),
                                    ],
                                  ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FilledButtonWidget(
                    text: 'Order pay',
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder:
                            (context) =>
                                Center(child: CircularProgressIndicator()),
                      );
                      final response = await NuveiSdkFlutter().debit(
                        userInformation: User(
                          id: Constants.userId,
                          email: "email@gmail.com",
                        ),
                        ordeInformation: Order(
                          amount: 88.9,
                          description: "breakfast",
                          devReference: "reference",
                          vat: 0,
                          taxableAmount: 0,
                          taxPercentage: 0,
                        ),
                        cardInformation: CardModel(
                          token: cardModel?.token ?? '',
                        ),
                      );
                      Navigator.pop(context);
                      if (!response.error) {
                        log(jsonEncode(response.data));
                        showDialog(
                          context: context,
                          builder:
                              (context) => Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Center(
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Card(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              response.data,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            FilledButtonWidget(
                                              text: "Close",
                                              onPressed: () async {
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
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        // body: Center(
        //   child: FilledButtonWidget(
        //     text: 'Listar tarjetas',
        //     onPressed: () {
        //       Navigator.pushNamed(context, 'list_card');
        //     },
        //   ),
        // ),
      ),
    );
  }
}
