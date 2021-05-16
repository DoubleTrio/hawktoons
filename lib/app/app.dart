import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:history_app/onboarding/onboarding.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseUserRepository>(
          create: (_) => FirebaseUserRepository()
        ),
        RepositoryProvider<FirestorePoliticalCartoonRepository>(
          create: (_) => FirestorePoliticalCartoonRepository()
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<OnboardingSeenCubit>(
            create: (_) => OnboardingSeenCubit()
          ),
          BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              userRepository: context.read<FirebaseUserRepository>()
            )
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = context.select((ThemeCubit cubit) => cubit.state);
    var lightPrimary = const Color(4284612846);
    var lightColorScheme = const ColorScheme.light().copyWith(
      primary: lightPrimary,
      primaryVariant: lightPrimary.withOpacity(0.8),
      secondary: Colors.yellow,
      secondaryVariant: Colors.yellow.withOpacity(0.8),
      onBackground: Colors.black38,
    );

    var darkPrimary = const Color(0xFFDEA7FF);
    var darkColorScheme = const ColorScheme.dark().copyWith(
      primary: darkPrimary,
      primaryVariant: darkPrimary.withOpacity(0.8),
      secondary: Colors.yellow,
      secondaryVariant: Colors.yellow.withOpacity(0.8),
      onBackground: Colors.white60,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(fontWeight: FontWeight.bold)
        ),
        dividerColor: Colors.grey.shade200,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: lightColorScheme.background,
          selectedItemColor: lightColorScheme.secondary,
          selectedLabelStyle:
            TextStyle(color: lightColorScheme.onSurface),
          unselectedLabelStyle:
            TextStyle(color: lightColorScheme.onSurface),
          unselectedItemColor: lightColorScheme.onSecondary),
          fontFamily: 'SanFrancisco',
          appBarTheme: AppBarTheme(
            backgroundColor: lightPrimary,
          ),
          textTheme: const TextTheme(
            subtitle1: TextStyle(
              fontSize: 16,
            ),
          ),
          colorScheme: lightColorScheme,
          highlightColor: lightPrimary.withOpacity(0.2),
          splashColor: lightPrimary.withOpacity(0.1),
          floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: lightPrimary)),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'SanFrancisco',
        primaryColor: darkPrimary,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3C3C3C),
        ),
        dividerColor: Colors.grey.shade900,
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(fontWeight: FontWeight.bold)
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF3C3C3C),
          selectedItemColor: darkColorScheme.secondary,
          selectedLabelStyle: TextStyle(color: darkColorScheme.onSurface),
          unselectedLabelStyle:
            TextStyle(color: darkColorScheme.onSurface),
          unselectedItemColor: darkColorScheme.onSecondary),
        textTheme: const TextTheme(
          subtitle1: TextStyle(
            fontSize: 16,
          ),
        ),
        colorScheme: darkColorScheme,
        highlightColor: darkPrimary.withOpacity(0.2),
        splashColor: darkPrimary.withOpacity(0.1),
        floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: darkPrimary)),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: themeMode == ThemeMode.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
        child: const OnboardingFlow(),
      )
    );
  }
}
