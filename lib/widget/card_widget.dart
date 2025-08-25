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
  final String svgCard;
  final List<Color> gradientCard;
  const CardWidget({
    super.key,
    this.holderName = 'Card´s holder',
    this.cardNumber = '*************** ',
    this.expirationDate = 'MM/YY',
    this.cvcCode = 'CVC/CVVC',
    required this.controllerCard,
    required this.svgCard,
    required this.gradientCard,
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
            gradient: LinearGradient(colors: widget.gradientCard),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  widget.svgCard,
                  width: size.width * 0.15,
                  package: 'nuvei_sdk_flutter',
                ),
                 Align(
                  alignment: Alignment.center,
                   child: Text(
                            widget.cardNumber.trim().isNotEmpty ? widget.cardNumber : '**** **** **** ****',
                   
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.longestSide * 0.021,
                              color: Colors.white,
                            ),
                          ),
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
                            fontSize: size.longestSide * 0.016,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.holderName.trim().isEmpty
                              ? 'JONH DOE'
                              : widget.holderName,
                          style: TextStyle(
                            fontSize: size.longestSide * 0.016,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Expiration date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.longestSide * 0.016,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.expirationDate.trim().isEmpty
                              ? 'MM/YY'
                              : widget.expirationDate,
                          style: TextStyle(
                            fontSize: size.longestSide * 0.016,
                            color: Colors.white,
                          ),
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
            gradient: LinearGradient(colors: widget.gradientCard),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: size.width,

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey[600]!, Colors.transparent],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CVV/CVC',
                      style: TextStyle(
                        fontSize: size.longestSide * 0.016,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.cvcCode.trim().isEmpty ? '123' : widget.cvcCode,
                      style: TextStyle(
                        fontSize: size.longestSide * 0.016,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
