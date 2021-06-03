import 'package:flutter/material.dart';
import 'package:hawktoons/widgets/widgets.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:shimmer/shimmer.dart';

class CartoonCard extends StatelessWidget {
  const CartoonCard({
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
          child: Card(
            color: theme.dividerColor,
            elevation: 10,
            child: Column(
              children: [
                FittedBox(
                  fit: BoxFit.cover,
                  child: CachedImage(
                    url: cartoon.downloadUrl,
                    loadingWidget: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 3,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Shimmer.fromColors(
                        baseColor: theme.dividerColor,
                        highlightColor: theme.backgroundColor,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
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
    );
  }
}