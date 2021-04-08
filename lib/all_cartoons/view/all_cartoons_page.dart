import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/all_cartoons/bloc/all_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class AllCartoonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllCartoonsBloc(
          cartoonRepository: FirestorePoliticalCartoonRepository())
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
        if (state is AllCartoonsInProgress) {
          return const Center(
              key: Key('AllCartoonsView_AllCartoonsInProgress'),
              child: CircularProgressIndicator());
        } else if (state is AllCartoonsLoaded) {
          return Center(
              key: const Key('AllCartoonsView_AllCartoonsLoaded'),
              child: Text(state.cartoons.first.dateString));
        } else {
          return const Text('Error',
              key: Key('AllCartoonsView_AllCartoonsLoadFailure'));
        }
      },
    );
  }
}
