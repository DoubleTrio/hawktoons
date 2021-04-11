import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    final l10n = context.l10n;
    final locale = Platform.localeName;
    final mockPoliticalCartoonList = [
      PoliticalCartoon(
          timeConverter: TimeAgo(l10n: l10n, locale: locale),
          id: '1',
          author: 'Harper Weekly',
          date: Timestamp.now(),
          description: 'This a cartoon description and this will be added on'
              ' later and more text to the container',
          unitId: UnitId.unit1,
          downloadUrl:
              'https://images.unsplash.com/photo-1425321488784-32cdca45e94e?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=MnwxfDB8MXxyYW5kb218fHx8fHx8fHwxNjE3OTcyMzIw&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1600'),
      PoliticalCartoon(
          timeConverter: TimeAgo(l10n: l10n, locale: locale),
          id: '2',
          author: 'Test Cartoon',
          date: Timestamp.fromDate(
              DateTime.now().subtract(const Duration(seconds: 9))),
          description: 'This a cartoon description and this will be added on'
              ' later and more text to the container',
          unitId: UnitId.unit3,
          downloadUrl:
              'https://images.unsplash.com/photo-1515966097209-ec48f3216288?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1950&q=80'),
      PoliticalCartoon(
          timeConverter: TimeAgo(l10n: l10n, locale: locale),
          id: '3',
          author: 'Test Cartoon',
          date: Timestamp.fromDate(DateTime.utc(2020)),
          description:
              'This a cartoon description and thidddds will be added on'
              ' later and more text to the container',
          unitId: UnitId.unit6,
          downloadUrl:
              'https://images.unsplash.com/photo-1617984445208-7447d026dc9d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'),
      PoliticalCartoon(
          timeConverter: TimeAgo(l10n: l10n, locale: locale),
          id: '4',
          author: 'Test Cartoon',
          date: Timestamp.fromDate(
              DateTime.now().subtract(const Duration(minutes: 1))),
          description: 'This a cartoon description and this will be added on'
              ' later and more text to the container',
          unitId: UnitId.unit3,
          downloadUrl:
              'https://images.unsplash.com/photo-1515966097209-ec48f3216288?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1950&q=80'),
      PoliticalCartoon(
          timeConverter: TimeAgo(l10n: l10n, locale: locale),
          id: '5',
          author: 'Test Cartoon',
          date: Timestamp.fromDate(
              DateTime.now().subtract(const Duration(minutes: 2))),
          description: 'This a cartoon description and this will be added on'
              ' later and more text to the container',
          unitId: UnitId.unit3,
          downloadUrl:
              'https://images.unsplash.com/photo-1515966097209-ec48f3216288?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1950&q=80'),
    ];

    return BlocBuilder<AllCartoonsBloc, AllCartoonsState>(
      builder: (context, state) {
        if (state is AllCartoonsInProgress) {
          return const Center(
              key: Key('AllCartoonsView_AllCartoonsInProgress'),
              child: CircularProgressIndicator());
        } else if (state is AllCartoonsLoaded) {
          var stateDouble = [
            ...mockPoliticalCartoonList,
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
              key: Key('AllCartoonsView_AllCartoonsLoadFailure'));
        }
      },
    );
  }
}
