import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.header,
  }) : super(key: key);

  final String header;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      header: true,
      child: Text(
        header,
        style: theme.textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onBackground,
          letterSpacing: 1.05,
        ),
      ),
    );
  }
}
