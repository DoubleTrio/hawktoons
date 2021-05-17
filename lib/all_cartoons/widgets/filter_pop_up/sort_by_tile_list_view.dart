import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/all_cartoons/blocs/blocs.dart';
import 'package:history_app/all_cartoons/widgets/widgets.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class SortByTileListView extends StatelessWidget {
  const SortByTileListView({Key? key, required this.modes}): super(key: key);

  final List<SortByMode> modes;

  @override
  Widget build(BuildContext context) {
    final selectedSortByMode = context.watch<SortByCubit>().state;
    final onSortByTileTap = (SortByMode sortByMode) {
      return context.read<SortByCubit>().selectSortBy(sortByMode);
    };

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: modes.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var mode = modes[index];
        return SortByTile(
          key: Key('SortByMode_Button_${mode.index}'),
          selected: mode == selectedSortByMode,
          onTap: () => onSortByTileTap(mode),
          header: mode.header
        );
      }
    );
  }
}
