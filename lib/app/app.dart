import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:history_app/onboarding/onboarding.dart';
import 'package:history_app/theme/theme.dart';
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
    final themeMode = context.watch<ThemeCubit>().state;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
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
