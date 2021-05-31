import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/theme/constants.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final primary = colorScheme.primary;
    final onSurface = colorScheme.onSurface;

    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.all(ThemeConstants.sPadding),
      ),
    );

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: ThemeConstants.mPadding),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              key: const Key('ButtonRowHeader_ResetButton'),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.all(ThemeConstants.sPadding),
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
                  style: textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.filter_list, color: onSurface),
              ],
            ),
            Semantics(
              child: TextButton(
                style: buttonStyle,
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
