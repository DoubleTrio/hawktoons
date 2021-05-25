import 'package:flutter/material.dart';

class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton({
    Key? key,
    required this.onTap,
    required this.backgroundColor,
    required this.label,
    required this.hint,
    required this.icon,
    required this.text,
    this.width = double.infinity,
  }) : super(key: key);

  final VoidCallback onTap;
  final Color backgroundColor;
  final String label;
  final String hint;
  final Widget icon;
  final Widget text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(16),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor,
          ),
        ),
        child: Semantics(
          button: true,
          label: label,
          hint: hint,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
              Align(
                alignment: Alignment.center,
                child: text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
