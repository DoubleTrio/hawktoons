// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/home/home_screen.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:history_app/theme_data.dart';
import 'package:history_app/utils/utils.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<AuthenticationBloc>(
            create: (_) =>
                AuthenticationBloc(userRepository: FirebaseUserRepository())
                  ..add(StartApp()))
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = context.select((ThemeCubit cubit) => cubit.state);

    return MaterialApp(
      themeMode: themeMode,
      theme: lightThemeData,
      darkTheme: ThemeData(
          accentColor: Colors.lightGreenAccent,
          appBarTheme: const AppBarTheme(color: Colors.lightGreenAccent)),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {},
      home: AuthBlocBuilder(),
    );
  }
}

class AuthBlocBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Platform.localeName;

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return MultiBlocProvider(
            key: const Key('DailyCartoonPage_Authenticated'),
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<AllCartoonsBloc>(
                  create: (_) => AllCartoonsBloc(
                      cartoonRepository: FirestorePoliticalCartoonRepository(
                          timeConverter: TimeAgo(l10n: l10n, locale: locale)))
                    ..add(LoadAllCartoons())),
              BlocProvider<UnitCubit>(create: (_) => UnitCubit())
            ],
            child: HomeScreen(),
          );
        } else if (state is Unauthenticated) {
          return const Text(
            'Unauthenticated',
            key: Key('DailyCartoonPage_Unauthenticated'),
          );
        } else {
          return const CircularProgressIndicator(
              key: Key('DailyCartoonPage_Uninitialized'));
        }
      },
    );
  }
}
