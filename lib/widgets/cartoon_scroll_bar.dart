import 'package:flutter/material.dart';

class CartoonScrollBar extends StatelessWidget {
  CartoonScrollBar({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RawScrollbar(
        radius: const Radius.circular(10),
        thickness: 4,
        thumbColor: theme.colorScheme.onBackground.withOpacity(0.2),
        child: child);
  }
}
