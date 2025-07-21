import 'package:flutter/widgets.dart';
import 'package:nuvei_sdk_flutter_example/home/home_page.dart';
import 'package:nuvei_sdk_flutter_example/list_cards/list_cards_page.dart';
import 'package:nuvei_sdk_flutter_example/main.dart';

class AppRouter {
  String initialRoute = 'welcome';
  static Map<String, Widget Function(BuildContext)> routes = {
    'welcome': (_) => WelcomeExample(),
    'home': (_) => HomePage(),
    'list_card': (_)=> ListCardsPage()
  };
}
