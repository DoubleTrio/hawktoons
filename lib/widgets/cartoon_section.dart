import 'package:flutter/material.dart';

class CartoonSection extends StatelessWidget {
  const CartoonSection({Key? key, required this.title, required this.body})
      : super(key: key);

  final String title;
  final Widget body;

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
          body,
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
