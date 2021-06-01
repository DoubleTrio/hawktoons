import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomTile({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 1,
            color: theme.dividerColor
          )
        )
      ),
      child: child,
    );
  }
}