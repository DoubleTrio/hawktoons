import 'package:flutter/material.dart';

class CartoonScrollBar extends StatelessWidget {

  const CartoonScrollBar({Key? key, required this.child}): super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RawScrollbar(
      radius: const Radius.circular(10),
      thickness: 4,
      thumbColor: theme.colorScheme.onBackground.withOpacity(0.2),
      child: child
    );
  }
}
