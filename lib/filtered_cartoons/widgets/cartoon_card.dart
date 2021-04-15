import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

class CartoonCard extends StatelessWidget {
  CartoonCard({required this.cartoon});

  final PoliticalCartoon cartoon;

  final temp = Uint8List(500);

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
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: cartoon.downloadUrl,
                      ))),
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
                Text('Unit ${cartoon.unit.index}: ${cartoon.unit.name}'),
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
