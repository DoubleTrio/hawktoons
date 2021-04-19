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
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              children: [
                Image.network(cartoon.downloadUrl),
                const Text('Add Text here'),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ));
  }
}
