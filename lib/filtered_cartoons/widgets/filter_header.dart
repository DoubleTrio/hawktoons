import 'package:flutter/material.dart';

class FilterHeader extends StatelessWidget {
  FilterHeader({required this.header});

  final String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      width: double.infinity,
      child: Text(
        header,
        style: const TextStyle(
            color: Colors.black38, fontSize: 22, fontWeight: FontWeight.bold),
        // textAlign: TextAlign.left,
      ),
    );
  }
}
