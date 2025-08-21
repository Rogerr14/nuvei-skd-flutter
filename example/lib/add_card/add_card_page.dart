
import 'package:flutter/material.dart';
import 'package:nuvei_sdk_flutter/widget/form_add_card_widget.dart';


class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormAddCardWidget()
          ],
        ),
      ),
    );
  }
}