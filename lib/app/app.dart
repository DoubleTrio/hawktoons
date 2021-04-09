// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/auth/bloc/authentication_event.dart';
import 'package:history_app/home/home_screen.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:history_app/tab/bloc/tab.dart';
import 'package:history_app/theme/cubit/theme_cubit.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../theme/theme.dart';

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
                  ..add(AppStarted()))
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
      home: AuthBlocBuilder(),
    );
  }
}

class AuthBlocBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return BlocProvider(
            key: const Key('DailyCartoonPage_Authenticated'),
            create: (context) => TabBloc(),
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
