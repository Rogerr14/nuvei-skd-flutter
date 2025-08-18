import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:nuvei_sdk_flutter/widget/card_widget.dart';
import 'package:nuvei_sdk_flutter/widget/text_form_field_widget.dart';

class FormAddCardWidget extends StatefulWidget {
  const FormAddCardWidget({super.key});

  @override
  State<FormAddCardWidget> createState() => _FormAddCardWidgetState();
}

class _FormAddCardWidgetState extends State<FormAddCardWidget> {
  final TextEditingController _numberCardController = TextEditingController();
  final TextEditingController _holdenNameController = TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();
  final TextEditingController _cvcCodeController = TextEditingController();
  final controller = FlipCardController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CardWidget(
            controllerCard: controller,
            holderName: _holdenNameController.text,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormFieldWidget(
              controller: _holdenNameController,
              hintText: 'Holder´s Name',
              onChanged: (p0) {
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormFieldWidget(
              controller: _numberCardController,
              hintText: 'Number Card',
              onChanged: (p0) {
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
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormFieldWidget(
                    controller: _cvcCodeController,
                    hintText: 'CVV/CVC',
                    onTap: () {
                      controller.flipcard();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
