import 'package:flutter/material.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class CartoonCard extends StatelessWidget {
  CartoonCard({required this.cartoon});

  final PoliticalCartoon cartoon;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(cartoon.id),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(cartoon.downloadUrl)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text('(${cartoon.publishedString})',
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                RichText(
                    text: TextSpan(
                        text: 'By ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                        text: cartoon.author,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      )
                    ])),
                const SizedBox(height: 6),
                Text('Unit ${cartoon.unitId.index}: ${cartoon.unitName}'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        cartoon.dateString,
                        style: const TextStyle(color: Colors.grey),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
