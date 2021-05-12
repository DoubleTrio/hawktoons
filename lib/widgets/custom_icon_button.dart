import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.size = 25
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      iconSize: size,
      splashRadius: size * 0.80,
      color: Colors.white,
    );
  }
}
