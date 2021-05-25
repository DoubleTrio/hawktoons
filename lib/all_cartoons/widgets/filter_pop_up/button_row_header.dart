import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(8),
                ),
              ),
              key: const Key('ButtonRowHeader_ResetButton'),
              onPressed: onReset,
              child: Semantics(
                sortKey: const OrdinalSortKey(1),
                button: true,
                hint: 'Tap to reset the image filters',
                label: 'Reset button',
                child: Text(
                  'Reset',
                  style: TextStyle(color: onSurface, fontSize: 16),
                ),
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
            Semantics(
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(8),
                  ),
                ),
                key: const Key('ButtonRowHeader_ApplyFilterButton'),
                onPressed: onFilter,
                child: Semantics(
                  sortKey: const OrdinalSortKey(0),
                  button: true,
                  hint: 'Tap to apply your current image filters',
                  label: 'Apply filter button',
                  child: Text(
                    'Apply',
                    style: TextStyle(color: primary, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
