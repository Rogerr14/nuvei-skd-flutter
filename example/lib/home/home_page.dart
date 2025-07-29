import 'package:flutter/material.dart';
import 'package:nuvei_sdk_flutter/model/card_model.dart';
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
          title: Image.asset(ThemeConfig().logoImagePath, width: 100),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.1,
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width,
                child: DataTable(
                  showBottomBorder: true,
                  columnSpacing: 0,
                  columns: [
                    DataColumn(label: Container()),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Price')),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Icon(Icons.shopping_bag_rounded)),
                        DataCell(Text("2")),
                        DataCell(Text("Milk Shake")),
                        DataCell(Text("\$13.90")),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Icon(Icons.shopping_bag_rounded)),
                        DataCell(Text("2")),
                        DataCell(Text("Milk Shake")),
                        DataCell(Text("\$13.90")),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Icon(Icons.shopping_bag_rounded)),
                        DataCell(Text("2")),
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
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: (cardModel == null)? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                              [
                                Text("No Card Selected", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("Need to select a card to continue"),

                              ]
                                   
                            
                          ):
                          Column(
                            children: [
                              Text(cardModel?.holderName ?? ''),
                              Text('---- ---- ---- ${cardModel?.number ?? ''}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 19),
                  FilledButtonWidget(text: 'Order pay'),
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
