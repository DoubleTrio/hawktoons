import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:history_app/widgets/widgets.dart';
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
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final maxImageHeight = height / 2.5;

    final _bodyTextStyle = theme.textTheme.bodyText1!
      .copyWith(color: theme.colorScheme.onSurface, letterSpacing: 1.05);

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
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartoonSection(
                title: 'PUBLISHED',
                body: Text(cartoon.publishedString, style: _bodyTextStyle)
              ),
              if (cartoon.author != '') ...[
                const CartoonSectionDivider(),
                CartoonSection(
                  key: Key('CartoonSection_Author_${cartoon.id}'),
                  title: 'AUTHOR',
                  body: Text(cartoon.author, style: _bodyTextStyle)
                )
              ],
              const CartoonSectionDivider(),
              CartoonSection(
                title: 'IMAGE TYPE',
                body: Text(cartoon.type.imageType, style: _bodyTextStyle)
              ),
              const CartoonSectionDivider(),
              CartoonSection(
                title: 'TAGS',
                body: Column(
                  children: [
                    ...cartoon.tags.map((tag) =>
                      BulletBody(text: tag.name, style: _bodyTextStyle)
                    )
                  ],
                ),
              ),
              const CartoonSectionDivider(),
              CartoonSection(
                title: 'DESCRIPTION',
                body: Text(cartoon.description, style: _bodyTextStyle)
              ),
            ],
          ),
        ),
      ],
    );
  }
}
