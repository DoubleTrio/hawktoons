import 'package:flutter/material.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({Key? key, required this.header}) : super(key: key);

  final String header;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 12 * 2),
      width: double.infinity,
      child: Text(
        header,
        style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
