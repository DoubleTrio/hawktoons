import 'package:flutter/material.dart';
import 'package:hawktoons/appearances/constants.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({Key? key, required this.header}) : super(key: key);

  final String header;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(left: ThemeConstants.mPadding * 2),
      width: double.infinity,
      child: Semantics(
        header: true,
        child: Text(
          header,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
