import 'package:flutter/material.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter.dart';
import 'package:nuvei_sdk_flutter/widget/filled_button_widget.dart';
import 'package:nuvei_sdk_flutter_example/constanst/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      body: Center(
        child: FilledButtonWidget(
          text: 'Listar tarjetas',
          onPressed: () {
            Navigator.pushNamed(context, 'list_card');
          },
        ),
      ),
    );
  }
}
