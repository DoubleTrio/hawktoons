import 'package:flutter/material.dart';

class SectionPlaceholder extends StatelessWidget {
  const SectionPlaceholder({
    Key? key,
    required this.headerPlaceholderWidth,
    required this.bodyPlaceholderWidth,
    required this.shouldAddExtra,
  }) : super(key: key);

  final double headerPlaceholderWidth;
  final double bodyPlaceholderWidth;
  final bool shouldAddExtra;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Container(
            width: headerPlaceholderWidth,
            height: 14,
            color: Colors.white,
          ),
          const SizedBox(height: 18),
          Container(
            width: bodyPlaceholderWidth,
            height: 10,
            color: Colors.white,
          ),

          if (shouldAddExtra) ...[
            const SizedBox(height: 6),
            Container(
              width: bodyPlaceholderWidth,
              height: 10,
              color: Colors.white,
            ),
            const SizedBox(height: 6),
            Container(
              width: bodyPlaceholderWidth,
              height: 10,
              color: Colors.white,
            ),
            const SizedBox(height: 6),
            Container(
              width: bodyPlaceholderWidth - 100,
              height: 10,
              color: Colors.white,
            ),
          ],
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
