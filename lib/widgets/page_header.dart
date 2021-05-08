import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  PageHeader({required this.header});

  final String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      child: Text(header,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.bold)),
    );
  }
}
