import 'package:flutter/material.dart';
import 'package:hawktoons/theme/theme.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key, required this.header}) : super(key: key);

  final String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ThemeConstants.mPadding),
      width: double.infinity,
      child: Semantics(
        header: true,
        child: Text(
          header,
          style: Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
