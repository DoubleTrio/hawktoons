import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({required this.cartoon});

  final PoliticalCartoon cartoon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          // leading: IconButton(
          //     icon: const Icon(
          //       Icons.arrow_back_outlined,
          //       color: Colors.white,
          //     ),
          //     onPressed: () => Navigator.of(context).pop()),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  child: Center(
                    child: Hero(
                        tag: 'Cartoon${cartoon.id}',
                        child: CachedNetworkImage(
                          imageUrl: cartoon.downloadUrl,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  LinearProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
