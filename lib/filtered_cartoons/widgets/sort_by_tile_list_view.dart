import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/widgets/widgets.dart';

class SortByTileListView extends StatelessWidget {
  SortByTileListView({required this.modes});

  final List<SortByMode> modes;

  @override
  Widget build(BuildContext context) {
    final selectedSortByMode = context.watch<SortByCubit>().state;
    final onSortByTileTap = (SortByMode sortByMode) =>
        context.read<SortByCubit>().selectSortBy(sortByMode);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
          itemCount: modes.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var mode = modes[index];
            return SortByTile(
                key: Key('SortByMode_${mode.index}'),
                selected: mode == selectedSortByMode,
                onTap: () => onSortByTileTap(mode),
                header: mode.header);
          }),
    );
  }
}
