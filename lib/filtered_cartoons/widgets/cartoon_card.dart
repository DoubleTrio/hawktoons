import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:history_app/utils/time_ago.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class CartoonCard extends StatelessWidget {
  CartoonCard({required this.cartoon, required this.onTap});

  final PoliticalCartoon cartoon;
  final VoidCallback onTap;

  final temp = Uint8List(500);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
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
              child: CachedNetworkImage(
                imageUrl: cartoon.downloadUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    LinearProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('(${cartoon.publishedString})',
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  RichText(
                      text: TextSpan(
                          text: 'By ',
                          style: const TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                          text: cartoon.author,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        )
                      ])),
                  const SizedBox(height: 6),
                  Text('Unit ${cartoon.unit.index}: ${cartoon.unit.name}'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          TimeAgo(
                                  l10n: context.l10n,
                                  locale: Platform.localeName)
                              .timeAgoSinceDate(cartoon.date),
                          style: const TextStyle(color: Colors.grey),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
