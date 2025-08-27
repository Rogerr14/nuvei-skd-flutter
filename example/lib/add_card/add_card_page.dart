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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: FormAddCardWidget(
        email: 'erick.guillen@nuvei.com',
        userId: '4',
        onLoading: (value) {
          if (value) {
            showDialog(
              context: context,
              builder:
                  (context) => Center(child: CircularProgressIndicator()),
            );
          } else {
            Navigator.pop(context);
          }
        },
        onErrorProcess:(error) {
          
        },
        onSuccesProcess: (approved) {
          
        },
      ),
    );
  }
}
