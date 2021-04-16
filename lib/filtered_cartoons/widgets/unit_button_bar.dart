import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/widgets/unit_button.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class UnitButtonBar extends StatelessWidget {
  UnitButtonBar({required this.units});

  final List<Unit> units;

  @override
  Widget build(BuildContext context) {
    final selectedUnit = context.watch<UnitCubit>().state;

    final onUnitButtonTap = (Unit unit) => context
        .read<UnitCubit>()
        .selectUnit(selectedUnit == unit ? Unit.all : unit);

    return Wrap(
      spacing: 5,
      children: [
        ...units.map((unit) => UnitButton(
            key: Key('Unit_${unit.index}_Button'),
            unit: unit,
            onTap: () => onUnitButtonTap(unit),
            selected: selectedUnit == unit)),
      ],
    );
  }
}
