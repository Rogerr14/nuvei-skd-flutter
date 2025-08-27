

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nuvei_sdk_flutter/model/refund_payment_model/refund_response_model.dart';
import 'package:nuvei_sdk_flutter/model/transaaction_response.dart';
import 'package:nuvei_sdk_flutter/model/transaction_model.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter.dart';
import 'package:nuvei_sdk_flutter/widget/filled_button_widget.dart';
import 'package:nuvei_sdk_flutter_example/environments/theme_config.dart';



class PaymentDetailPage extends StatefulWidget {
  
  const PaymentDetailPage({super.key});

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  TransactionResponse? detailPayment;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_){
      detailPayment = ModalRoute.of(context)!.settings.arguments as TransactionResponse;
      setState(() {
        
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(ThemeConfig().logoImagePath, width: 100),
      ),
      body: SizedBox(
      height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Payment Details', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),),
              ),
              Text('Transaction Id:',  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  
                )),
              Text(detailPayment?.transaction.id ?? '', ),
              const SizedBox(height: 10,), 
              Text('Amount',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  
                )),
              Text('\$ ${detailPayment?.transaction.amount ?? ''}'),
              const SizedBox(height: 10,), 
              Text('Authorization code:', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  
                )),
              Text(detailPayment?.transaction.authorizationCode ?? ''),
              const SizedBox(height: 10,), 
                Text('Status:', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  
                )),
              Text(detailPayment?.transaction.status ?? ''),
              const SizedBox(height: 30,),
              FilledButtonWidget(text: 'Refund', fontWeight: FontWeight.bold, fontSize: 18,color: Colors.redAccent, onPressed: ()async{
                showDialog(
                          context: context,
                          builder:
                              (context) =>
                                  Center(child: CircularProgressIndicator()),
                        );
                final response = await NuveiSdkFlutter().refund(transaction: TransactionModel(id: detailPayment?.transaction.id));
                Navigator.pop(context);
                if(!response.error){
                  RefundResponseModel refundInfo = refundResponseModelFromJson(jsonEncode(response.data));
                   showDialog(
        context: context,
        builder:
            (context) => Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(refundInfo.status ?? '', style: TextStyle(fontSize: 20)),
                          FilledButtonWidget(
                            width: 200,
                            text: "Close",
                            onPressed: () async {
                              Navigator.pop(context);
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
              },), 
            ],
          ),
        ),
      ) ,
    );
  }
}