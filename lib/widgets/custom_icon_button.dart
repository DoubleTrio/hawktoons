import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.hint,
    this.size = 25
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget icon;
  final String label;
  final String hint;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Semantics(
        label: label,
        hint: hint,
        child: icon,
      ),
      onPressed: onPressed,
      iconSize: size,
      splashRadius: size * 0.80,
      color: Colors.white,
    );
  }
}
