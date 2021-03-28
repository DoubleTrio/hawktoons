import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/daily_cartoon/repository/daily_cartoon_repository.dart';
import 'package:history_app/l10n/l10n.dart';

class DailyCartoonPage extends StatelessWidget {
  const DailyCartoonPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DailyCartoonBloc(
          dailyCartoonRepository: FirebaseDailyCartoonRepository())
        ..add(LoadDailyCartoon()),
      child: DailyCartoonView(),
    );
  }
}

class DailyCartoonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.dailyCartoonAppBarTitle)),
      body: BlocBuilder<DailyCartoonBloc, DailyCartoonState>(
          builder: (context, state) {
        if (state is DailyCartoonInProgress) {
          return const CircularProgressIndicator();
        }
        if (state is DailyCartoonLoaded) {
          return Text(state.dailyCartoon.toString(),
              key: const Key('dailyCartoonView_dailyCartoonLoaded_text'));
        }
        if (state is DailyCartoonFailure) {
          return const Text('Error while fetching political cartoon',
              key: Key('dailyCartoonView_dailyCartoonFailure_text'),
              style: TextStyle(color: Colors.red));
        } else {
          throw Exception('Unhandled state for DailyCartoon');
        }
      }),
    );
  }
}
