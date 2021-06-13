import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/widgets/widgets.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:shimmer/shimmer.dart';

class StaggeredCartoonCard extends StatelessWidget {
  const StaggeredCartoonCard({
    Key? key,
    required this.cartoon,
    required this.onTap
  }) : super(key: key);

  final PoliticalCartoon cartoon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      child: Ink(
        child: InkWell(
          onTap: onTap,
          borderRadius: ThemeConstants.sBorderRadius,
          child: Card(
            color: theme.dividerColor,
            shape: RoundedRectangleBorder(
              borderRadius: ThemeConstants.sBorderRadius,
            ),
            elevation: 10,
            child: ClipRRect(
              borderRadius: ThemeConstants.sBorderRadius,
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 3,
                    ),
                    child: CachedImage(
                      url: cartoon.downloadUrl,
                      loadingWidget: Shimmer.fromColors(
                        baseColor: theme.dividerColor,
                        highlightColor: theme.backgroundColor,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  CartoonCardDetails(cartoon: cartoon),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}