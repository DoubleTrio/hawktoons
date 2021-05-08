import 'package:flutter/material.dart';

class ScaffoldTitle extends StatelessWidget {
  ScaffoldTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(color: Colors.white));
  }
}
