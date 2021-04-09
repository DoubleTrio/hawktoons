import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class DailyCartoonPage extends StatelessWidget {
  DailyCartoonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DailyCartoonBloc(
          dailyCartoonRepository: FirestorePoliticalCartoonRepository())
        ..add(LoadDailyCartoon()),
      child: DailyCartoonView(),
    );
  }
}

class DailyCartoonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(child: PoliticalCartoonCardLoader())),
    );
  }
}

class PoliticalCartoonCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<DailyCartoonBloc, DailyCartoonState>(
        builder: (context, state) {
      if (state is DailyCartoonInProgress) {
        return const CircularProgressIndicator(
            key: Key('DailyCartoonView_DailyCartoonInProgress'));
      } else if (state is DailyCartoonLoad) {
        return Column(
          children: [
            Text(l10n.dailyCartoonTitle),
            Image.asset(
              'assets/images/unit5/rail-splitter.jpg',
              key: const Key('DailyCartoonView_DailyCartoonLoad'),
            ),
          ],
        );
      } else {
        return const Text('Error while fetching political cartoon',
            key: Key('DailyCartoonView_DailyCartoonFailure'),
            style: TextStyle(color: Colors.red));
      }
    });
  }
}
