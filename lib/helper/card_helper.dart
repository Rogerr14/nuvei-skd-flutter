import 'package:nuvei_sdk_flutter/env/theme/app_theme.dart';
import 'package:nuvei_sdk_flutter/model/card_info_model.dart';

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
      gradientColor: ['#333', '#000'],
    ),
  );
  }
}
