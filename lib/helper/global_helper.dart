import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class GlobalHelper {


  static var logger =
      Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false));

  String _uniqueToken(String timeStamp, String key) {
    var uniqueToken = utf8.encode('$key$timeStamp');
    String uniqueTokenString = sha256.convert(uniqueToken).toString();
    return uniqueTokenString;
  }

  String generateToken(String code, String key) {
    String timeStamp =
        (DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000).toString();
    String uniqueToken = _uniqueToken(timeStamp, key);
    String tokenFinal = code + timeStamp + uniqueToken;
    return tokenFinal;
  }

  static bool validateCardNumber(String cardNumber) {
    // Eliminar espacios y guiones
    cardNumber = cardNumber.replaceAll(RegExp(r'[\s-]+'), '');
    
    // Verificar que solo contenga dígitos y tenga al menos 1 dígito
    if (!RegExp(r'^\d+$').hasMatch(cardNumber) || cardNumber.isEmpty) {
      return false;
    }

    int sum = 0;
    bool isEven = false;

    // Iterar desde el último dígito hacia el primero
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      isEven = !isEven;
    }

    // El número es válido si la suma es divisible por 10
    return sum % 10 == 0;
  }
  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

}
