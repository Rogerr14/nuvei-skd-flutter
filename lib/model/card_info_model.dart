



import 'package:nuvei_sdk_flutter/env/theme/app_theme.dart';

class CardInfo {
  final String type;
  final RegExp regex;
  final String mask;
  final int cvcNumber;
  final List<int> validLengths;
  final String typeCode;
  final String icon;
  final List<String> gradientColor;

  const CardInfo({
    required this.type,
    required this.regex,
    required this.mask,
    required this.cvcNumber,
    required this.validLengths,
    required this.typeCode,
    required this.icon,
    required this.gradientColor,
  });
}

List<CardInfo> cardTypes = [
   CardInfo(
    type: 'Visa',
    regex: RegExp(r'^4'),
    mask: '#### #### #### ####',
    cvcNumber: 3,
    validLengths: [13, 16, 19],
    typeCode: 'vi',
    icon: AppTheme.iconVisaSvg,
    gradientColor: ['#1a1f71', '#3d5bf6'],
  ),
 CardInfo(
    type: 'Mastercard',
    regex: RegExp(r'^(5[1-5]|2[2-7])'),
    mask: '#### #### #### ####',
    cvcNumber: 3,
    validLengths: [16],
    typeCode: 'mc',
    icon:AppTheme.iconMastercardSvg,
    gradientColor: ['#eb001b', '#f79e1b'],
  ),
   CardInfo(
    type: 'American Express',
    regex: RegExp(r'^3[47]'),
    mask: '#### ###### #####',
    cvcNumber: 4,
    validLengths: [15],
    typeCode: 'ax',
    icon: AppTheme.iconAmexSvg,
    gradientColor: ['#2e77bb', '#1e5799'],
  ),
  CardInfo(
    type: 'Diners',
    regex: RegExp(r'^3(0[0-5]|[68])'),
    mask: '#### ###### ####',
    cvcNumber: 3,
    validLengths: const [14],
    typeCode: 'di',
    icon:AppTheme.iconDinersvg,
    gradientColor: const ['#006ba1', '#00b5e2'],
  ),
  CardInfo(
    type: 'Discover',
    regex: RegExp(r'^(6011|65|64[4-9]|622)'),
    mask: '#### #### #### ####',
    cvcNumber: 3,
    validLengths: const [16, 19],
    typeCode: 'dc',
    icon: AppTheme.iconDiscoverSvg,
    gradientColor: const ['#ff6f00', '#ff8f00'],
  ),
  CardInfo(
    type: 'Maestro',
    regex: RegExp(r'^(5[06789]|6)'),
    mask: '#### #### #### ####',
    cvcNumber: 3,
    validLengths: const [12,13,14,15,16,17,18, 19],
    typeCode: 'mc',
    icon: AppTheme.iconMaestroSvg,
    gradientColor: const ['#ff6f00', '#ff8f00'],
  ),
  CardInfo(
    type: 'BBVA',
    regex: RegExp(r'^(6011|65|64[4-9]|622)'),
    mask: '#### #### #### ####',
    cvcNumber: 3,
    validLengths: const [16, 19],
    typeCode: 'bbva',
    icon: AppTheme.iconUnknowCard ,    
    gradientColor: const ['#ff6f00', '#ff8f00'],
  ),
];