import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:hawktoons/utils/utils.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class CartoonCardDetails extends StatelessWidget {
  const CartoonCardDetails({
    Key? key,
    required this.cartoon,
  }) : super(key: key);

  final PoliticalCartoon cartoon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final onBackground = colorScheme.onBackground;
    final onSurface = colorScheme.onSurface;
    final dateText = TimeAgo(
      l10n: context.l10n,
      locale: Platform.localeName,
    ).timeAgoSinceDate(cartoon.timestamp);
    final cardColor = theme.cardColor;
    final allTagsText = cartoon.tags.map(
            (tag) => tag.index
    ).join(', ');

    final imageType = cartoon.type.imageType;
    final publishedString = cartoon.publishedString;

    return Container(
      padding: EdgeInsets.all(ThemeConstants.mPadding),
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Semantics(
            sortKey: const OrdinalSortKey(1),
            child: Text(
              '$imageType ($publishedString)',
              style: theme.textTheme.bodyText2!.copyWith(
                color: onBackground,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (cartoon.author != '') ...[
            Semantics(
              sortKey: const OrdinalSortKey(0),
              child: RichText(
                text: TextSpan(
                  text: '${l10n.cartoonCardByText} ',
                  style: textTheme.bodyText2!.copyWith(
                    color: onSurface,
                    fontStyle: FontStyle.italic,
                  ),
                  children: [
                    TextSpan(
                      text: cartoon.author,
                      style: const TextStyle(
                        letterSpacing: 0.5,
                      ),
                    )
                  ]
                )
              ),
            ),
            const SizedBox(height: 12)
          ],
          Semantics(
            label: '${l10n.cartoonCardPostedText} $dateText',
            child: Row(
              children: [
                Icon(
                  Icons.timer,
                  size: 20,
                  color: onBackground,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    dateText,
                    style: textTheme.bodyText2!.copyWith(
                      color: onBackground,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Semantics(
                sortKey: const OrdinalSortKey(2),
                child: Text(
                  '${l10n.cartoonCardTagsText}: $allTagsText',
                  style: textTheme.bodyText2!.copyWith(
                    color: colorScheme.onBackground.withOpacity(0.2),
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
