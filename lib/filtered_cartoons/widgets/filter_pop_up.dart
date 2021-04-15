import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/filtered_cartoons/widgets/unit_tile.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class FilterPopUp extends StatelessWidget {
  final unitsList = Unit.values;

  @override
  Widget build(BuildContext context) {
    final selectedUnit = context.watch<UnitCubit>().state;
    final units = Unit.values.sublist(1);
    final onTap = (Unit unit) => context
        .read<UnitCubit>()
        .selectUnit(selectedUnit == unit ? Unit.all : unit);

    return DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.75,
        maxChildSize: 1,
        expand: false,
        builder: (context, scroller) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  child: const Text(
                    'Select Filters',
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: ListView.builder(
                    itemExtent: 35,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: units.length,
                    itemBuilder: (context, index) {
                      var unit = units[index];
                      return UnitTile(
                          key: Key('Unit_${unit.index}_Tile'),
                          unit: unit,
                          onTap: () => onTap(unit),
                          selected: selectedUnit == unit);
                    }),
              ),
              const Spacer(),
              Expanded(
                flex: 1,
                child: ApplyFilterButton(
                    key: const Key('FilterPopUp_ApplyFilterButton'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      context
                          .read<FilteredCartoonsBloc>()
                          .add(UpdateFilter(selectedUnit));
                    }),
              )
            ],
          );
        });
  }
}
