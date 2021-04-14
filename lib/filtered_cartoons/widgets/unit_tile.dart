import 'package:flutter/material.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class UnitTile extends StatelessWidget {
  UnitTile({required this.unit, required this.onTap, required this.selected});

  final Unit unit;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final index = unit.index;
    final isValidPeriod = unit.periodRange.isValidPeriod;
    final name = unit.name;
    final unitText = '${isValidPeriod ? 'Unit $index: ' : ''}';
    final title = '$unitText$name';
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(0),
        width: double.infinity,
        child: Row(
          children: [
            Transform.scale(
                scale: 0.8,
                child: Checkbox(value: selected, onChanged: (_) => {})),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}
