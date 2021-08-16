import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/utils/utils.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class CartoonCardAuthor extends StatelessWidget {
  const CartoonCardAuthor({
    Key? key,
    required this.author
  }) : super(key: key);

  final String author;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Semantics(
      sortKey: const OrdinalSortKey(0),
      child: RichText(
        text: TextSpan(
          text: '${l10n.cartoonCardByText} ',
          style: textTheme.bodyText2!.copyWith(
            fontStyle: FontStyle.italic,
          ),
          children: [
            TextSpan(
              text: author,
              style: const TextStyle(
                letterSpacing: 0.5,
              ),
            )
          ]
        )
      ),
    );
  }
}

class CartoonPostedDate extends StatelessWidget {
  const CartoonPostedDate({
    Key? key,
    required this.timestamp,
  }) : super(key: key);

  final Timestamp timestamp;

  @override
  Widget build(BuildContext context) {

    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final dateText = TimeAgoConverter(
      l10n: context.l10n,
      locale: Platform.localeName,
    ).timeAgoSinceDate(timestamp);
    final onBackground = Theme.of(context).colorScheme.onBackground;

    return Semantics(
      label: '${l10n.cartoonCardPostedText} $dateText',
      child: Row(
        children: [
          Icon(
            Icons.timer,
            size: 20,
            color: onBackground,
          ),
          const SizedBox(width: 4),
          Text(
            dateText,
            style: textTheme.bodyText2!.copyWith(
              color: onBackground,
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}

class CartoonPublishedDate extends StatelessWidget {
  const CartoonPublishedDate({
    Key? key,
    required this.type,
    required this.publishedString,
  }) : super(key: key);

  final ImageType type;
  final String publishedString;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Semantics(
      sortKey: const OrdinalSortKey(1),
      child: Text(
        '${type.imageType} ($publishedString)',
        style: textTheme.bodyText2!.copyWith(
          color: colorScheme.onBackground,
        ),
      ),
    );
  }
}

class CartoonsTags extends StatelessWidget {
  const CartoonsTags({
    Key? key,
    required this.tags,
  }) : super(key: key);

  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final allTagsText = tags.map(
      (tag) => tag.index
    ).join(', ');

    return Row(
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
    );
  }
}

class CartoonCardDetails extends StatelessWidget {
  const CartoonCardDetails({
    Key? key,
    required this.cartoon,
  }) : super(key: key);

  final PoliticalCartoon cartoon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemeConstants.mPadding),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CartoonPublishedDate(
            type: cartoon.type,
            publishedString: cartoon.publishedString
          ),
          const SizedBox(height: 12),
          if (cartoon.author != '') ...[
            CartoonCardAuthor(author: cartoon.author),
            const SizedBox(height: 12)
          ],
          CartoonPostedDate(timestamp: cartoon.timestamp),
          const SizedBox(height: 16),
          CartoonsTags(tags: cartoon.tags),
        ],
      ),
    );
  }
}

