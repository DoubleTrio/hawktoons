import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/theme/constants.dart';
import 'package:hawktoons/widgets/cartoon_body/widgets.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:shimmer/shimmer.dart';

class CartoonBody extends StatelessWidget {
  const CartoonBody({
    Key? key,
    required this.cartoon,
  }) : super(key: key);

  final PoliticalCartoon cartoon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final bodyText1 = theme.textTheme.bodyText1!;
    final height = MediaQuery.of(context).size.height;
    final maxImageHeight = height / 2.5;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      key: Key('CartoonBody_${cartoon.id}'),
      children: [
        Container(
          color: Theme.of(context).dividerColor,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: maxImageHeight,
              ),
              child: Semantics(
                image: true,
                child: CachedNetworkImage(
                  imageUrl: cartoon.downloadUrl,
                  progressIndicatorBuilder: (_, __, ___) =>
                    Shimmer.fromColors(
                      baseColor: theme.dividerColor,
                      highlightColor: theme.backgroundColor,
                      child: Container(
                        width: double.infinity,
                        height: maxImageHeight,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: ThemeConstants.mPadding),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartoonSection(
                title: l10n.cartoonBodyPublishedText,
                body: Text(cartoon.publishedString, style: bodyText1)
              ),
              if (cartoon.author != '') ...[
                const CartoonSectionDivider(),
                CartoonSection(
                  key: Key('CartoonSection_Author_${cartoon.id}'),
                  title: l10n.cartoonBodyAuthorText,
                  body: Text(cartoon.author, style: bodyText1)
                )
              ],
              const CartoonSectionDivider(),
              CartoonSection(
                title: l10n.cartoonBodyImageTypeText,
                body: Text(cartoon.type.imageType, style: bodyText1)
              ),
              const CartoonSectionDivider(),
              CartoonSection(
                title: l10n.cartoonBodyTagsText,
                body: Column(
                  children: [
                    ...cartoon.tags.map((tag) =>
                      CartoonBulletBody(text: tag.name, style: bodyText1)
                    )
                  ],
                ),
              ),
              const CartoonSectionDivider(),
              CartoonSection(
                title: l10n.cartoonBodyDescriptionText,
                body: Text(cartoon.description, style: bodyText1)
              ),
            ],
          ),
        ),
      ],
    );
  }
}
