import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuvei_sdk_flutter/model/add_card_model/extra_params_model.dart';

class GlobalHelper {
  static var logger = Logger(
    printer: PrettyPrinter(methodCount: 0, printEmojis: false),
  );

  String _uniqueToken(String timeStamp, String key) {
    var uniqueToken = utf8.encode('$key$timeStamp');
    String uniqueTokenString = sha256.convert(uniqueToken).toString();
    return uniqueTokenString;
  }

  String generateToken(String code, String key) {
    String timeStamp =
        (DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000).toString();
    log('Tiempoo $timeStamp');
    String uniqueToken = _uniqueToken(timeStamp, key);
    String token = '$code;$timeStamp;$uniqueToken';
    String tokenFinal = base64Encode(utf8.encode(token));
    return tokenFinal;
  }

  

  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }



  Future<BrowserInfo> getBrowserInfo(BuildContext context)async{
    final response = await http.get(Uri.parse('https://api.ipify.org/?format=json'));
    final ip = jsonDecode(response.body)['ip'];
    String language = View.of(context).platformDispatcher.locale.languageCode;
    double screenWidth =  MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int timezoneOffset = DateTime.now().timeZoneOffset.inMinutes;
    
    logger.w(language);
    logger.w(ip);
    return BrowserInfo(
      ip: ip,
      language: language,
      javaEnabled: false,
      jsEnabled: true,
      screenHeight: screenHeight.round(),
      screenWidth: screenWidth.round(),
      timezoneOffset: timezoneOffset,
      acceptHeader: "text/html",
    );
  }

}
