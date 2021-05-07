import 'package:flutter/material.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class UnitButton extends StatelessWidget {
  UnitButton(
      {Key? key,
      required this.unit,
      required this.onTap,
      required this.selected})
      : super(key: key);

  final Unit unit;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final onBackground = colorScheme.onBackground;
    final btnColor = selected ? primary : onBackground;

    return TextButton(
      onPressed: onTap,
      child: Text(
        unit.name,
        style: TextStyle(fontSize: 12, color: btnColor),
      ),
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
          foregroundColor: MaterialStateProperty.all<Color>(btnColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: btnColor)))),
    );
  }
}
