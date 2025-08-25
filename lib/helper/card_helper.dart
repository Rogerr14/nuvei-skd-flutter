import 'package:flutter/material.dart';
import 'package:nuvei_sdk_flutter/env/theme/app_theme.dart';
import 'package:nuvei_sdk_flutter/model/add_card_model/card_info_model.dart';

class CardHelper {
  String applyMask(String numberCard) {

    CardInfo infoCard = getCardInfo(numberCard);




    String result = "";
    int textIndex = 0;
    String mask = infoCard.mask;

    for (int i = 0; i < mask.length && textIndex < numberCard.length; i++) {
      if (mask[i] == "#") {
        result += numberCard[textIndex];
        textIndex++;
      } else {
        result += mask[i];
      }
    }

    return result;
  }

  CardInfo getCardInfo(String number) {
    
return cardTypes.firstWhere(
    (cardInfo) => cardInfo.regex.hasMatch(number.trim()),
    orElse: () => CardInfo(
      type: 'Unknown',
      regex: RegExp(r'^$'),
      mask: '#### #### #### ####',
      cvcNumber: 3,
      validLengths: [16],
      typeCode: '',
      icon: AppTheme.iconUnknowCard,
      gradientColor: [Color(0xFF333333), Color(0xFF000000)],
    ),
  );
  }



  String formatExpiry(String value) {
  // Solo mantener dígitos
  String digits = value.replaceAll(RegExp(r'\D'), '');

  // Cortar a máximo 4 dígitos (MMYY)
  String limited = digits.length > 4 ? digits.substring(0, 4) : digits;

  // Validar mes
  if (limited.isNotEmpty) {
    String month = limited.length >= 2 ? limited.substring(0, 2) : limited;

    // Si se ingresa un solo dígito mayor a '1', lo corregimos automáticamente
    if (month.length == 1 && int.parse(month) > 1) {
      month = '0$month';
      limited = month + (limited.length > 1 ? limited.substring(1) : '');
    }

    // Si ya hay 2 dígitos, validamos que estén entre 01 y 12
    if (month.length == 2) {
      int monthNum = int.parse(month);
      if (monthNum < 1 || monthNum > 12) {
        // Si es inválido, no lo mostramos (solo el primer dígito si acaso)
        return limited.length > 1 ? limited.substring(1, 2) : '';
      }
    }
  }

  // Insertar '/' después de los primeros 2 dígitos
  if (limited.length >= 3) {
    return '${limited.substring(0, 2)}/${limited.substring(2)}';
  } else {
    return limited;
  }
}



String? validateExpiryDate(String? expiry) {
  if (expiry == null || expiry.trim().length != 5) {
    return 'Expiry date is not valid'; // reemplaza con tu traducción si usas i18n
  }

  final parts = expiry.split('/');
  if (parts.length != 2) return 'Expiry date is not valid';

  final month = int.tryParse(parts[0]);
  final year = int.tryParse(parts[1]);

  if (month == null || year == null || month < 1 || month > 12) {
    return 'Expiry date is not valid';
  }

  final now = DateTime.now();
  final currentYear = now.year % 100; // solo últimos 2 dígitos
  final currentMonth = now.month;

  if (year < currentYear || (year == currentYear && month < currentMonth)) {
    return 'Expiry date is not valid';
  }

  return null; // válido
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
}
