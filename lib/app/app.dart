// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:history_app/theme/cubit/theme_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
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
      theme: ThemeData(
        accentColor: const Color(0xFF13B9FF),
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
      ),
      darkTheme: ThemeData(
          accentColor: Colors.lightGreenAccent,
          appBarTheme: const AppBarTheme(color: Colors.lightGreenAccent)),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const DailyCartoonPage(),
    );
  }
}
