import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:history_app/widgets/widgets.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class CartoonBody extends StatelessWidget {
  CartoonBody({required this.cartoon, required this.addImagePadding});

  final PoliticalCartoon cartoon;
  final bool addImagePadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var _bodyTextStyle = theme.textTheme.bodyText1!
      .copyWith(color: theme.colorScheme.onSurface, letterSpacing: 1.05);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      key: Key('CartoonBody_${cartoon.id}'),
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: addImagePadding ? 12 : 0),
          color: Theme.of(context).dividerColor,
          child: Center(
            child: Container(
              child: CachedNetworkImage(imageUrl: cartoon.downloadUrl),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2
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
              CartoonSectionDivider(),
              CartoonSection(
                title: 'AUTHOR',
                body: Text(cartoon.author, style: _bodyTextStyle)
              ),
              CartoonSectionDivider(),
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
              CartoonSectionDivider(),
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
