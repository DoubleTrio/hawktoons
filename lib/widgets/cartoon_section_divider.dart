import 'package:flutter/material.dart';

class CartoonSectionDivider extends StatelessWidget {
  const CartoonSectionDivider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Divider(
      height: 1,
      color: theme.colorScheme.onBackground,
      thickness: 1.2,
    );
  }
}
