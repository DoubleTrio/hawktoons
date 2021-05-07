import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

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

    final reset = () => {
          context.read<UnitCubit>().selectUnit(Unit.all),
          context.read<SortByCubit>().selectSortBy(SortByMode.latestPosted)
        };

    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final onBackground = colorScheme.onBackground;
    final onSurface = colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              key: const Key('ButtonRowHeader_ResetButton'),
              onPressed: reset,
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ))),
              child: Text(
                'Reset',
                style: TextStyle(color: onBackground),
              )),
          Row(
            children: [
              Text(
                'Filters',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 6),
              Icon(Icons.filter_list, color: onSurface),
            ],
          ),
          TextButton(
            key: const Key('ButtonRowHeader_ApplyFilterButton'),
            child: Text(
              'Apply',
              style: TextStyle(color: primary),
            ),
            onPressed: onFilter,
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
          ),
        ],
      ),
    );
  }
}
