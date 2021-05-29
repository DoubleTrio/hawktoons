import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hawktoons/l10n/l10n.dart';

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
    final l10n = context.l10n;
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
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(8),
                ),
              ),
              onPressed: onReset,
              child: Semantics(
                sortKey: const OrdinalSortKey(1),
                button: true,
                label: l10n.filterPopUpResetButtonLabel,
                hint: l10n.filterPopUpResetButtonHint,
                child: Text(
                  l10n.filterPopUpResetButtonText,
                  style: TextStyle(color: onSurface, fontSize: 16),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  l10n.filterPopUpHeader,
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
                  label: l10n.filterPopUpApplyButtonLabel,
                  hint: l10n.filterPopUpApplyButtonHint,
                  child: Text(
                    l10n.filterPopUpApplyButtonText,
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
