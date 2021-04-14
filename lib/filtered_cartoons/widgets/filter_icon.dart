import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';

class FilterIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _filteredCartoonsBloc = BlocProvider.of<FilteredCartoonsBloc>(context);
    var _unitCubit = BlocProvider.of<UnitCubit>(context);

    return Material(
      key: const Key('FilteredCartoonsPage_FilterIcon'),
      child: IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return MultiBlocProvider(providers: [
                  BlocProvider.value(value: _unitCubit),
                  BlocProvider.value(value: _filteredCartoonsBloc)
                ], child: FilterPopUp());
              })),
    );
  }
}
