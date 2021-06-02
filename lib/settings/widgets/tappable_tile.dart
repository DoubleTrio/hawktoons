import 'package:flutter/material.dart';
import 'package:hawktoons/theme/constants.dart';

class TappableTile extends StatelessWidget {
  const TappableTile({
    Key? key,
    required this.child,
    required this.onTap,
    required this.isLast,
    this.leading,
    this.selected = false,
    this.navigable = false,
  }): super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final bool isLast;
  final Widget? leading;
  final bool selected;
  final bool navigable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          border: Border(
            top: BorderSide(
              width: 1,
              color: theme.dividerColor
            ),
            bottom: BorderSide(
              width: isLast ? 1 : 0,
              color: theme.dividerColor
            )
          )
        ),
        child: InkWell(
          highlightColor: theme.dividerColor,
          splashColor: theme.dividerColor,
          onTap: onTap,
          child: Padding(
            padding: ThemeConstants.defaultContainerPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      if (leading != null)
                        ...[
                          leading!,
                          SizedBox(width: ThemeConstants.mPadding)
                        ],
                      child,
                    ],
                  )
                ),
                if (selected) const Icon(Icons.check),
                if (navigable) Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: theme.colorScheme.onBackground,
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}