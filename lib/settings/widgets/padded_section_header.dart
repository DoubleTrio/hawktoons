import 'package:flutter/material.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/widgets/widgets.dart';

class PaddedSectionHeader extends StatelessWidget {
  const PaddedSectionHeader({
    Key? key,
    required this.header,
  }) : super(key: key);

  final String header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ThemeConstants.sPadding,
        right: ThemeConstants.mPadding,
        bottom: 4,
      ),
      child: SectionHeader(header: header),
    );
  }
}
