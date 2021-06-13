import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class SortByTileListView extends StatelessWidget {
  const SortByTileListView({
    Key? key,
    required this.modes,
    required this.onTileTap
  }) : super(key: key);

  final List<SortByMode> modes;
  final ValueChanged<SortByMode> onTileTap;

  @override
  Widget build(BuildContext context) {
    final _selectedSortByMode = context.select<FilterSheetCubit, SortByMode>(
      (cubit) => cubit.state.sortByMode
    );

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: modes.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final mode = modes[index];
        return SortByTile(
          key: Key('SortByMode_Button_${mode.index}'),
          selected: mode == _selectedSortByMode,
          onTap: () => onTileTap(mode),
          header: mode.header
        );
      }
    );
  }
}
