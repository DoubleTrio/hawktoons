import 'package:flutter/material.dart';

class OnboardingTextButton extends StatelessWidget {
  const OnboardingTextButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.textStyle})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: textStyle),
      ),
    );
  }
}
