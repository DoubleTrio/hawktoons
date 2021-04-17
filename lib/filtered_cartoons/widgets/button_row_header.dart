import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';

class ButtonRowHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedUnit = context.watch<UnitCubit>().state;
    final sortByMode = context.watch<SortByCubit>().state;
    final onFilter = () => {
          Navigator.of(context).pop(),
          context.read<AllCartoonsBloc>().add(LoadAllCartoons(sortByMode)),
          context.read<FilteredCartoonsBloc>().add(UpdateFilter(selectedUnit))
        };

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            key: const Key('ButtonRowHeader_ResetButton'),
            onPressed: () {},
            child: const Text(
              'Reset',
              style: TextStyle(color: Colors.black),
            )),
        Row(
          children: [
            const Text(
              'Filters',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 6),
            const Icon(Icons.filter_list, color: Colors.black),
          ],
        ),
        TextButton(
          key: const Key('ButtonRowHeader_ApplyFilterButton'),
          child: const Text(
            'Done',
            style: TextStyle(color: Colors.orange),
          ),
          onPressed: onFilter,
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ))),
        ),
      ],
    );
  }
}
