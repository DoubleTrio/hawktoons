import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:history_app/all_cartoons/bloc/all_cartoons.dart';
import 'package:history_app/all_cartoons/widgets/widgets.dart';
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
      child: AllCartoonsView(),
    );
  }
}

class AllCartoonsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCartoonsBloc, AllCartoonsState>(
      builder: (context, state) {
        if (state is AllCartoonsLoading) {
          return const Center(
              key: Key('AllCartoonsView_AllCartoonsLoading'),
              child: CircularProgressIndicator());
        } else if (state is AllCartoonsLoaded) {
          var stateDouble = [
            ...state.cartoons,
          ];

          return StaggeredGridView.countBuilder(
            key: const Key('AllCartoonsView_AllCartoonsLoaded'),
            crossAxisCount: 4,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 8.0,
            itemCount: stateDouble.length,
            itemBuilder: (context, index) =>
                CartoonCard(cartoon: stateDouble[index]),
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
          );
        } else {
          return const Text('Error',
              key: Key('AllCartoonsView_AllCartoonsFailed'));
        }
      },
    );
  }
}
