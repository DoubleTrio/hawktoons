import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  BodyText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.bodyText1!
        .copyWith(color: theme.colorScheme.onSurface, letterSpacing: 1.05),
    );
  }
}
