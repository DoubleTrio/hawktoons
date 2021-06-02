import 'package:flutter/material.dart';
import 'package:hawktoons/widgets/widgets.dart';

class CartoonSection extends StatelessWidget {
  const CartoonSection({Key? key, required this.title, required this.body})
    : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          SectionHeader(header: title),
          const SizedBox(height: 18),
          body,
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
