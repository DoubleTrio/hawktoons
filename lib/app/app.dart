import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseUserRepository = FirebaseUserRepository();
    final _firebaseCartoonRepository = FirestorePoliticalCartoonRepository();
    final _authBloc = AuthenticationBloc(
      userRepository: _firebaseUserRepository
    );
    final _primaryColorCubit = PrimaryColorCubit();
    final _onboardingSeenCubit = OnboardingSeenCubit();
    final _themeCubit = ThemeCubit();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _firebaseCartoonRepository,
        ),
        RepositoryProvider.value(
          value: _firebaseUserRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _authBloc),
          BlocProvider.value(value: _primaryColorCubit),
          BlocProvider.value(value: _onboardingSeenCubit),
          BlocProvider.value(value: _themeCubit),
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
    final primary = context.watch<PrimaryColorCubit>().state;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: createLightTheme(primary),
      darkTheme: createDarkTheme(primary),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black.withOpacity(0.20),
        ),
        child: const OnboardingFlow(),
      )
    );
  }
}
