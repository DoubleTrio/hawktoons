import 'package:flutter/material.dart';

class OnboardingTextButton extends StatelessWidget {
  const OnboardingTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.hint,
    required this.label,
    required this.textStyle,
    this.excludeSemantics = false,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final String hint;
  final String label;
  final TextStyle textStyle;
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: onPressed,
        child: Semantics(
          excludeSemantics: excludeSemantics,
          label: label,
          hint: hint,
          button: true,
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }
}
