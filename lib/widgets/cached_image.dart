import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.url,
    required this.loadingWidget,
    this.height,
    this.width,
  }) : super(key: key);

  final String url;
  final Widget loadingWidget;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      height: height,
      width: width,
      imageUrl: url,
      progressIndicatorBuilder: (_, __, ___) => loadingWidget,
    );
  }
}