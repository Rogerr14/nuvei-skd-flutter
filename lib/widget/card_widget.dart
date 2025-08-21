import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:nuvei_sdk_flutter/env/theme/app_theme.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CardWidget extends StatefulWidget {
  final FlipCardController controllerCard;
  final String holderName;
  final String cardNumber;
  final String expirationDate;
  final String cvcCode;
  const CardWidget({
    super.key,
    this.holderName = 'Card´s holder',
    this.cardNumber = '**** **** **** ****',
    this.expirationDate = 'MM/YY',
    this.cvcCode = 'CVC/CVVC', required this.controllerCard,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: FlipCard(
        rotateSide: RotateSide.left,
        controller: widget.controllerCard,
        animationDuration: const Duration(milliseconds: 500),
        frontWidget: Container(
          height: size.height * 0.25,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade600],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AppTheme.iconVisaSvg,
                  width: size.width * 0.15,
                  package: 'nuvei_sdk_flutter',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Card´s holder",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.longestSide * 0.02,
                          ),
                        ),
                        Text(
                          widget.holderName.trim().isEmpty ? 'JONH DOE' :widget.holderName ,
                          style: TextStyle(fontSize: size.longestSide * 0.02),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Expiration date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.longestSide * 0.02,
                          ),
                        ),
                        Text(
                          widget.expirationDate.trim().isEmpty ? 'MM/YY':widget.expirationDate,
                          style: TextStyle(fontSize: size.longestSide * 0.02),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        backWidget: Container(
          height: size.height * 0.25,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade600],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AppTheme.iconVisaSvg,
                  width: size.width * 0.15,
                  package: 'nuvei_sdk_flutter',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
