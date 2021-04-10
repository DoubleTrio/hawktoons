import 'package:flutter/material.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class CartoonCard extends StatelessWidget {
  CartoonCard({required this.cartoon});

  final PoliticalCartoon cartoon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              Center(
                child: Text(cartoon.downloadUrl),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                Text(
                  cartoon.author,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
