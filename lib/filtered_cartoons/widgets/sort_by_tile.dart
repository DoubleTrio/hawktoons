import 'package:flutter/material.dart';

class SortByTile extends StatelessWidget {
  SortByTile(
      {Key? key,
      required this.selected,
      required this.onTap,
      required this.header})
      : super(key: key);

  final bool selected;
  final VoidCallback onTap;
  final String header;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      highlightColor: theme.colorScheme.primary.withOpacity(0.2),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12 * 2),
        child: Column(
          children: [
            // const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 5),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(header,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.subtitle1!.copyWith(
                          color: selected
                              ? colorScheme.primary
                              : colorScheme.onSurface)),
                  if (selected)
                    Icon(
                      Icons.check,
                      color: colorScheme.primary,
                      size: 18,
                    ),
                ],
              ),
            ),
            Divider(
              color: colorScheme.onBackground,
              thickness: 1,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
