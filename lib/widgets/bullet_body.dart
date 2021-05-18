import 'package:flutter/material.dart';

class BulletBody extends StatelessWidget {
  const BulletBody({Key? key, required this.text, required this.style})
      : super(key: key);

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.arrow_right),
        const SizedBox(width: 6),
        Text(text, style: style)
      ],
    );
  }
}
