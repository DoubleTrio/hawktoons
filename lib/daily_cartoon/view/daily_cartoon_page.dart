import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/l10n/l10n.dart';

class DailyCartoonPage extends Page {
  DailyCartoonPage() : super(key: const ValueKey('DailyCartoonPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
          DailyCartoonScreen(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class DailyCartoonScreen extends StatelessWidget {
  DailyCartoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            height: double.infinity,
            child: PoliticalCartoonCardLoader()),
      ),
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
            key: Key('DailyCartoonScreen_DailyCartoonInProgress'));
      } else if (state is DailyCartoonLoaded) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          key: const Key('DailyCartoonScreen_DailyCartoonLoaded'),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              // color: Colors.blue,
              child: Text(l10n.dailyCartoonTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              color: Theme.of(context).dividerColor,
              child: Center(
                child: Image.network(state.dailyCartoon.downloadUrl),
              ),
            ),
          ],
        );
      } else {
        return const Text('Error while fetching political cartoon',
            key: Key('DailyCartoonScreen_DailyCartoonFailed'),
            style: TextStyle(color: Colors.red));
      }
    });
  }
}
