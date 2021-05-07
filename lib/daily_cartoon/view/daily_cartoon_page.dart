import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/widgets/sign_out_icon.dart';
import 'package:intl/intl.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

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
    return BlocBuilder<DailyCartoonBloc, DailyCartoonState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              leading: SignOutIcon(
                size: 25,
                onPressed: () =>
                    context.read<AuthenticationBloc>().add(Logout()),
              ),
              title: Text(
                (state is DailyCartoonLoaded)
                    ? DateFormat.yMMMMEEEEd(Platform.localeName)
                        .format(state.dailyCartoon.published.toDate())
                    : ' ',
                style: const TextStyle(color: Colors.white),
              ),
              centerTitle: true),
          body: SingleChildScrollView(
            child: PoliticalCartoonCardLoader(),
            physics: const BouncingScrollPhysics(),
          ),
        );
      },
    );
  }
}

class PoliticalCartoonCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DailyCartoonBloc, DailyCartoonState>(
        builder: (context, state) {
      if (state is DailyCartoonInProgress) {
        return Container(
          height: 20,
          width: 20,
          child: SpinKitFadingCircle(
              color: Theme.of(context).colorScheme.primary,
              key: const Key('DailyCartoonScreen_DailyCartoonInProgress')),
        );
      } else if (state is DailyCartoonLoaded) {
        print(state);
        print('--------------------------');
        var cartoon = state.dailyCartoon;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          key: const Key('DailyCartoonScreen_DailyCartoonLoaded'),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              child: Text('Daily',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: Theme.of(context).dividerColor,
              child: Center(
                child: Image.network(cartoon.downloadUrl),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              // color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'PUBLISHED',
                    style: theme.textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    cartoon.publishedString,
                    style: theme.textTheme.bodyText1!
                        .copyWith(color: theme.colorScheme.onSurface),
                  ),
                  const SizedBox(height: 12),
                  Divider(height: 2, color: theme.colorScheme.onBackground),
                  const SizedBox(height: 24),
                  Text(
                    'AUTHOR',
                    style: theme.textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    cartoon.author,
                    style: theme.textTheme.bodyText1!
                        .copyWith(color: theme.colorScheme.onSurface),
                  ),
                  const SizedBox(height: 12),
                  Divider(height: 2, color: theme.colorScheme.onBackground),
                  const SizedBox(height: 24),
                  Text(
                    'UNIT',
                    style: theme.textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    cartoon.unit.name,
                    style: theme.textTheme.bodyText1!
                        .copyWith(color: theme.colorScheme.onSurface),
                  ),
                  const SizedBox(height: 12),
                  Divider(height: 2, color: theme.colorScheme.onBackground),
                  const SizedBox(height: 24),
                  Text(
                    'DESCRIPTION',
                    style: theme.textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '${cartoon.description} ${cartoon.description} ${cartoon.description}',
                    style: theme.textTheme.bodyText1!.copyWith(
                        color: theme.colorScheme.onSurface, height: 1.5),
                  ),
                  const SizedBox(height: 12),
                ],
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
