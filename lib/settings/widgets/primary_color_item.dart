import 'package:flutter/material.dart';
import 'package:hawktoons/appearances/appearances.dart';

class PrimaryColorItem extends StatelessWidget {
  const PrimaryColorItem({
    Key? key,
    required this.color,
    required this.colorName,
    required this.selected,
    required this.onPrimaryChange,
  }) : super(key: key);

  final Color color;
  final String colorName;
  final bool selected;
  final VoidCallback onPrimaryChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: Ink(
        child: InkWell(
          highlightColor: theme.dividerColor,
          splashColor: theme.dividerColor,
          onTap: onPrimaryChange,
          child: Container(
            constraints: const BoxConstraints(minWidth: 70),
            padding: EdgeInsets.all(ThemeConstants.mPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: selected
                    ? Icon(Icons.check, color: theme.colorScheme.onPrimary)
                    : const SizedBox.shrink(),
                ),
                const SizedBox(height: 6),
                Text(colorName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
