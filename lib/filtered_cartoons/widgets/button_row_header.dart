import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class ButtonRowHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedTag = context.watch<TagCubit>().state;
    final _sortByMode = context.watch<SortByCubit>().state;

    void _filter() {
      Navigator.of(context).pop();
      context.read<AllCartoonsBloc>().add(LoadAllCartoons(_sortByMode));
      context.read<FilteredCartoonsBloc>().add(UpdateFilter(_selectedTag));
    }

    void _reset() {
      context.read<TagCubit>().selectTag(Tag.all);
      context.read<SortByCubit>().selectSortBy(SortByMode.latestPosted);
    }

    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final onSurface = colorScheme.onSurface;

    final btnStyle = ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    )));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              key: const Key('ButtonRowHeader_ResetButton'),
              onPressed: _reset,
              style: btnStyle,
              child: Text(
                'Reset',
                style: TextStyle(color: onSurface),
              )),
          Row(
            children: [
              Text(
                'Filters',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: onSurface),
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
            onPressed: _filter,
            style: btnStyle,
          ),
        ],
      ),
    );
  }
}
