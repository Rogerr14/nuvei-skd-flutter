import 'package:flutter/material.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter.dart';
import 'package:nuvei_sdk_flutter/widget/filled_button_widget.dart';
import 'package:nuvei_sdk_flutter_example/environments/theme_config.dart';
import 'package:nuvei_sdk_flutter_example/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRouter.routes,
      initialRoute: AppRouter().initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeExample extends StatefulWidget {
  const WelcomeExample({super.key});

  @override
  State<WelcomeExample> createState() => _WelcomeExampleState();
}

class _WelcomeExampleState extends State<WelcomeExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Image.asset(ThemeConfig().logoImagePath, width: 240),
                Text("Sdk", style: TextStyle(fontSize: 25),),
                
              ],
            ),
            SizedBox(height: 10,),
            FilledButtonWidget(
              borderRadius: 20,
              text: 'Start simulation',
              fontSize: 20,
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
