import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:nuvei_sdk_flutter/helper/card_helper.dart';
import 'package:nuvei_sdk_flutter/helper/global_helper.dart';
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
  });

  final bool showBorderInput;
  final Color? borderColor;
  final Color? hintTextColor;
  final Color? textInputColor;
  final Color? backgroundInputColor;

  @override
  State<FormAddCardWidget> createState() => _FormAddCardWidgetState();
}

class _FormAddCardWidgetState extends State<FormAddCardWidget> {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CardWidget(
            controllerCard: controller,
            holderName: _holdenNameController.text,
            cardNumber: _numberCardController.text,
            cvcCode: _cvcCodeController.text,
            expirationDate: _expireDateController.text,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormFieldWidget(
              controller: _holdenNameController,
              hintText: 'Holder´s Name',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormFieldWidget(
              colorBorder: widget.borderColor ?? Colors.black,
              controller: _numberCardController,
              hintText: 'Number Card',
              inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
              onChanged: (value) {
                _numberCardController.text = CardHelper().applyMask(value);
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
                    controller: _expireDateController,
                    hintText: 'MM/YY',
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormFieldWidget(
                    controller: _cvcCodeController,
                    hintText: 'CVV/CVC',
                    focusNode: _cvcFocus,
                    maxLength: CardHelper().getCardInfo(_numberCardController.text).cvcNumber,
                    onTapOutside: () {
                      _cvcFlipCard();
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
          ),
          FilledButtonWidget(text: 'Add Card')
        ],
      ),
    );
  }
}
