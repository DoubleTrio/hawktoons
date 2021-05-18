import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:history_app/utils/time_ago.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class CartoonCard extends StatelessWidget {
  CartoonCard({Key? key, required this.cartoon, required this.onTap})
      : super(key: key);

  final PoliticalCartoon cartoon;
  final VoidCallback onTap;

  final temp = Uint8List(500);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final onBackground = colorScheme.onBackground;
    final onSurface = colorScheme.onSurface;
    final cardColor = theme.cardColor;

    return Material(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        onTap: onTap,
        child: Card(
          color: theme.dividerColor,
          key: Key(cartoon.id),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          child: Column(
            children: [
              Center(
                  child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 3),
                  child: CachedNetworkImage(
                    imageUrl: cartoon.downloadUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            LinearProgressIndicator(
                                value: downloadProgress.progress,
                                backgroundColor: primary),
                  ),
                ),
              )),
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(10.0)),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          '${cartoon.type.imageType} '
                          '(${cartoon.publishedString})',
                          style: TextStyle(color: onBackground)),
                      const SizedBox(height: 8),
                      if (cartoon.author != '') ...[
                        RichText(
                            key: Key('CartoonCard_Author_${cartoon.id}'),
                            text: TextSpan(
                                text: 'By ',
                                style: TextStyle(color: onSurface),
                                children: [
                                  TextSpan(
                                    text: cartoon.author,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: onSurface),
                                  )
                                ])),
                        const SizedBox(height: 12)
                      ],
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 20,
                            color: onBackground,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              TimeAgo(
                                      l10n: context.l10n,
                                      locale: Platform.localeName)
                                  .timeAgoSinceDate(cartoon.timestamp),
                              style: TextStyle(color: onBackground),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              'Tags: ${cartoon.tags.map((tag) => tag.index).join(', ')}',
                              style: TextStyle(
                                  color: theme.colorScheme.onBackground
                                      .withOpacity(0.2))),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
