import 'package:flutter/material.dart';

class ButtonRowHeader extends StatelessWidget {
  const ButtonRowHeader({
    Key? key,
    required this.onReset,
    required this.onFilter,
  }) : super(key: key);

  final VoidCallback onReset;
  final VoidCallback onFilter;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final onSurface = colorScheme.onSurface;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              key: const Key('ButtonRowHeader_ResetButton'),
              onPressed: onReset,
              child: Text(
                'Reset',
                style: TextStyle(color: onSurface),
              ),
            ),
            Row(
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: onSurface
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.filter_list, color: onSurface),
              ],
            ),
            TextButton(
              key: const Key('ButtonRowHeader_ApplyFilterButton'),
              onPressed: onFilter,
              child: Text(
                'Apply',
                style: TextStyle(color: primary),
              ),
            ),
          ],
        )
    );
  }
}
