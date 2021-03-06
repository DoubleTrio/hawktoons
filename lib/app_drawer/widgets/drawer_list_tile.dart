import 'package:flutter/material.dart';
import 'package:hawktoons/appearances/constants.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.label,
    required this.hint,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget icon;
  final String title;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).dividerColor,
      highlightColor: Theme.of(context).dividerColor,
      onTap: onTap,
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.only(left: ThemeConstants.mPadding),
          child: icon,
        ),
        title: Semantics(
          button: true,
          label: label,
          hint: hint,
          child: Text(title),
        ),
      ),
    );
  }
}
