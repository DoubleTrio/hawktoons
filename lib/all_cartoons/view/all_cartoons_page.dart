import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:history_app/all_cartoons/bloc/all_cartoons.dart';
import 'package:history_app/all_cartoons/widgets/widgets.dart';
import 'package:history_app/filtered_cartoons/bloc/filtered_cartoons.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:history_app/utils/utils.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class AllCartoonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Platform.localeName;
    return BlocProvider(
      create: (_) => AllCartoonsBloc(
          cartoonRepository: FirestorePoliticalCartoonRepository(
              timeConverter: TimeAgo(l10n: l10n, locale: locale)))
        ..add(LoadAllCartoons()),
      child: AllCartoonsMedium(),
    );
  }
}

class AllCartoonsMedium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilteredCartoonsBloc(
          allCartoonsBloc: BlocProvider.of<AllCartoonsBloc>(context)),
      child: AllCartoonsView(),
    );
  }
}

class AllCartoonsView extends StatefulWidget {
  @override
  _AllCartoonsViewState createState() => _AllCartoonsViewState();
}

class _AllCartoonsViewState extends State<AllCartoonsView> {
  final unitsList = Unit.values;

  Unit selectedUnit = Unit.all;

  void selectUnit(Unit unit) {
    setState(() {
      selectedUnit = unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredCartoonsBloc, FilteredCartoonsState>(
      builder: (context, state) {
        void onTap(Unit unit) => BlocProvider.of<FilteredCartoonsBloc>(context)
            .add(UpdateFilter(unit));

        if (state is FilteredCartoonsLoading) {
          return const Center(
              key: Key('AllCartoonsView_AllCartoonsLoading'),
              child: CircularProgressIndicator());
        } else if (state is FilteredCartoonsLoaded) {
          var stateDouble = [
            ...state.filteredCartoons,
          ];

          return Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                            child: AlertDialog(
                                title: const Text('Select Cartoon Filter'),
                                content: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      ...unitsList.map((unit) => ListTile(
                                          title: Text('Unit '
                                              '${unit.index}: ${unit.name}'),
                                          onTap: () => selectUnit(unit),
                                          visualDensity:
                                              VisualDensity.compact)),
                                      OutlinedButton(
                                          child: const Text('FILTER'),
                                          onPressed: () => {
                                                onTap(selectedUnit),
                                                Navigator.pop(context)
                                              })
                                    ],
                                  ),
                                )));
                      })),
              Expanded(
                child: StaggeredGridView.countBuilder(
                  key: const Key('AllCartoonsView_AllCartoonsLoaded'),
                  crossAxisCount: 4,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 8.0,
                  itemCount: stateDouble.length,
                  itemBuilder: (context, index) =>
                      CartoonCard(cartoon: stateDouble[index]),
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                ),
              ),
            ],
          );
        } else {
          return const Text('Error',
              key: Key('AllCartoonsView_AllCartoonsFailed'));
        }
      },
    );
  }
}
