import 'package:flutter/material.dart';

class CartoonSection extends StatelessWidget {
  CartoonSection({Key? key, required this.title, required this.body})
      : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            title,
            style: theme.textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
                letterSpacing: 1.1),
          ),
          const SizedBox(height: 18),
          Text(
            body,
            style: theme.textTheme.bodyText1!.copyWith(
                color: theme.colorScheme.onSurface, letterSpacing: 1.05),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
