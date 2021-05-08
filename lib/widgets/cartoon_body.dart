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
    Widget _buildImage() {
      return Center(
        child: Container(
          child: CachedNetworkImage(imageUrl: cartoon.downloadUrl),
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      key: Key('CartoonBody_${cartoon.id}'),
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: addImagePadding ? 12 : 0),
          color: Theme.of(context).dividerColor,
          child: _buildImage(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartoonSection(title: 'PUBLISHED', body: cartoon.publishedString),
              CartoonSectionDivider(),
              CartoonSection(title: 'AUTHOR', body: cartoon.author),
              CartoonSectionDivider(),
              CartoonSection(title: 'UNIT', body: cartoon.unit.name),
              CartoonSectionDivider(),
              CartoonSection(
                  title: 'DESCRIPTION',
                  body: cartoon.description.replaceAll('\\n', '\n')),
            ],
          ),
        ),
      ],
    );
  }
}
