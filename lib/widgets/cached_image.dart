import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.url,
    required this.loadingWidget,
  }) : super(key: key);

  final String url;
  final Widget loadingWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (_, __, ___) => loadingWidget,
    );
  }
}