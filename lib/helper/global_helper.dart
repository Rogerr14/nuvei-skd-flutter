import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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


}
