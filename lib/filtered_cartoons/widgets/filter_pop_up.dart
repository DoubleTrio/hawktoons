import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/widgets/unit_tile.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class FilterPopUp extends StatelessWidget {
  final unitsList = Unit.values;
  final Unit selUnit = Unit.all;

  @override
  Widget build(BuildContext context) {
    final selectedUnit = context.watch<UnitCubit>().state;
    final units = Unit.values.sublist(1);
    final onTap = (Unit unit) =>
        context.read<UnitCubit>().emit(selectedUnit == unit ? Unit.all : unit);

    return DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.75,
        maxChildSize: 1,
        expand: false,
        builder: (context, scroller) {
          return Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: const Text(
                  'Select Filters',
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.left,
                ),
              ),
              ListView.builder(
                  itemExtent: 40,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: units.length,
                  itemBuilder: (context, index) {
                    var unit = units[index];
                    return UnitTile(
                        unit: unit,
                        onTap: () => onTap(unit),
                        selected: selectedUnit == unit);
                  }),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.2, color: Colors.grey))),
                child: TextButton(
                  child: const Text(
                    'APPLY',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context
                        .read<FilteredCartoonsBloc>()
                        .add(UpdateFilter(selectedUnit));
                  },
                ),
              )
            ],
          );
        });
  }
}
