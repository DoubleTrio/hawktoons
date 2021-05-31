import 'package:flutter/material.dart';
import 'package:hawktoons/theme/constants.dart';

class AppScrollBar extends StatelessWidget {
  const AppScrollBar({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RawScrollbar(
      radius: Radius.circular(ThemeConstants.sRadius),
      thickness: 4,
      thumbColor: theme.colorScheme.onBackground.withOpacity(0.2),
      child: child
    );
  }
}
