import 'package:flutter/material.dart';

class CreateCartoonPageWidget extends StatelessWidget {
  const CreateCartoonPageWidget({
    required this.child,
    required this.onPress,
    required this.buttonText,
    Key? key
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPress;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          child: child,
        )
      ],
    );
  }
}
