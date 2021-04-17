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
    return TextButton(
      onPressed: onTap,
      child: Text(
        unit.name,
        style: const TextStyle(fontSize: 12),
      ),
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
          foregroundColor: MaterialStateProperty.all<Color>(
              selected ? Colors.orange : Colors.grey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                      color: selected ? Colors.orange : Colors.grey)))),
    );
  }
}
