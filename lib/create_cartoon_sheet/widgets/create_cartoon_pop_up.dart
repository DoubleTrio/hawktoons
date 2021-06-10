import 'package:flutter/material.dart';
import 'package:hawktoons/widgets/widgets.dart';

class CreateCartoonPopUp extends StatelessWidget {
  const CreateCartoonPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomDraggableSheet(
      child: Center(
        child: Text('Create Cartoon Sheet'),
      )
    );
  }
}
