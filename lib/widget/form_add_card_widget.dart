import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:nuvei_sdk_flutter/helper/card_helper.dart';
import 'package:nuvei_sdk_flutter/helper/global_helper.dart';
import 'package:nuvei_sdk_flutter/model/add_card_model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/user_model.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter_transaction_interface.dart';
import 'package:nuvei_sdk_flutter/widget/card_widget.dart';
import 'package:nuvei_sdk_flutter/widget/filled_button_widget.dart';
import 'package:nuvei_sdk_flutter/widget/text_form_field_widget.dart';

class FormAddCardWidget extends StatefulWidget {
  const FormAddCardWidget({
    super.key,
    this.showBorderInput = false,
    this.borderColor,
    this.hintTextColor,
    this.textInputColor,
    this.backgroundInputColor,
    required this.email,
    required this.userId,
    required this.onLoading  
    });

  final bool showBorderInput;
  final Color? borderColor;
  final Color? hintTextColor;
  final Color? textInputColor;
  final Color? backgroundInputColor;
  final String userId;
  final String email;
  final Function(bool value) onLoading;

  @override
  State<FormAddCardWidget> createState() => _FormAddCardWidgetState();
}

class _FormAddCardWidgetState extends State<FormAddCardWidget> {
  final _keyForm = GlobalKey<FormState>();
  final bool isLoading = false;
  final TextEditingController _numberCardController = TextEditingController();
  final TextEditingController _holdenNameController = TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();
  final TextEditingController _cvcCodeController = TextEditingController();

  bool _flipped = false;
  final controller = FlipCardController();
  final _cvcFocus = FocusNode();

  void _cvcFlipCard() async {
    GlobalHelper.logger.i('focus ${(_cvcFocus.hasFocus && !_flipped)}');
    if (_cvcFocus.hasFocus) {
      if (!_flipped) {
        await controller.flipcard();
        _flipped = true;
      }
    } else {
      if (_flipped) {
        await controller.flipcard();
        _flipped = false;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => {});
    _cvcFocus.addListener(_cvcFlipCard);
    super.initState();
  }



  _addCardProcess()async{
    widget.onLoading(true);
    final expiryDate =  _expireDateController.text.split('/');
    final expiryMonth = expiryDate[0];
    final expiryYear = expiryDate[1];

    final cleanNumber = _numberCardController.text.trim().replaceAll(' ', '');
    final bodyAddCard =  CardModel(
      number: cleanNumber,
      holderName: _holdenNameController.text.toUpperCase(),
      cvc: _cvcCodeController.text,
      expiryMonth: int.parse(expiryMonth),
      expiryYear: int.parse(expiryYear),
    );
    final useInfo = UserModel(id: widget.userId, email: widget.email);
    final response = await NuveiSdkFlutterTransactionInterface.instance.addCard(bodyAddCard, useInfo, context);
    GlobalHelper.logger.w(jsonEncode(response));
    widget.onLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _keyForm,
        child: Column(
          children: [
            CardWidget(
              svgCard:
                  CardHelper().getCardInfo(_numberCardController.text).icon,
              gradientCard:
                  CardHelper()
                      .getCardInfo(_numberCardController.text)
                      .gradientColor,
              controllerCard: controller,
              holderName: _holdenNameController.text,
              cardNumber: _numberCardController.text,
              cvcCode: _cvcCodeController.text,
              expirationDate: _expireDateController.text,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormFieldWidget(
                colorBorder: widget.borderColor ?? Colors.black,
                controller: _numberCardController,
                keyboardType: TextInputType.numberWithOptions(),

                autovalidateMode: AutovalidateMode.onUnfocus,
                hintText: 'Number Card',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !CardHelper()
                          .getCardInfo(_numberCardController.text)
                          .validLengths
                          .contains(value.trim().length)) {
                    return 'Card number is not valid';
                  }
                  if (!CardHelper.validateCardNumber(value)) {
                    return 'Card number is not valid';
                  }

                  return null;
                },
                onChanged: (value) {
                  _numberCardController.text = CardHelper().applyMask(value);
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormFieldWidget(
                controller: _holdenNameController,
                hintText: 'Holder´s Name',
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUnfocus,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Z ]')),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Holder name is not valid';
                  }
                  return null;
                },
                onChanged: (v) {
                  // _holdenNameController.text = v.toUpperCase();
                  setState(() {});
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      controller: _expireDateController,
                      hintText: 'MM/YY',
                      keyboardType: TextInputType.numberWithOptions(),
                      validator:
                          (value) => CardHelper().validateExpiryDate(value),
                      onChanged: (value) {
                        _expireDateController.text = CardHelper().formatExpiry(
                          value,
                        );
                        setState(() {});
                      },
                      maxLength: 5,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormFieldWidget(
                      controller: _cvcCodeController,
                      hintText: 'CVV/CVC',
                      onChanged: (va) {
                        setState(() {});
                      },
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      focusNode: _cvcFocus,
                      keyboardType: TextInputType.numberWithOptions(),
                      maxLength:
                          CardHelper()
                              .getCardInfo(_numberCardController.text)
                              .cvcNumber,

                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            CardHelper()
                                    .getCardInfo(_numberCardController.text)
                                    .cvcNumber !=
                                _cvcCodeController.text.length) {
                          return 'CVC is not valid';
                        }
                        return null;
                      },
                      onTapOutside: () {
                        _cvcFlipCard();
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            FilledButtonWidget(
              text: 'Add Card',
              onPressed: () {
                if (_keyForm.currentState!.validate()) {
                  _addCardProcess();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
