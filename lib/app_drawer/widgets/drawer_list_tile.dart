import 'package:flutter/material.dart';

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
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: icon,
      ),
      onTap: onTap,
      title: Semantics(
        button: true,
        label: label,
        hint: hint,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(title),
        ),
      ),
    );
  }
}
