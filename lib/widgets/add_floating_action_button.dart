import 'package:flutter/material.dart';

class AddFloatingActionButton extends StatelessWidget {
  const AddFloatingActionButton({
    Key? key,
    required this.label,
    required this.hint,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final String hint;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FloatingActionButton(
      onPressed: onPressed,
      child: Semantics(
        hint: hint,
        label: label,
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
      ),
    );
  }
}
