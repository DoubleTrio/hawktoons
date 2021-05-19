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
    final _firebaseUserRepository = FirebaseUserRepository();
    final _firebaseCartoonRepository = FirestorePoliticalCartoonRepository();
    final _onboardingSeenCubit = OnboardingSeenCubit();
    final _themeCubit = ThemeCubit();
    final _authBloc = AuthenticationBloc(
      userRepository: _firebaseUserRepository
    );
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _firebaseUserRepository,
        ),
        RepositoryProvider.value(
          value: _firebaseCartoonRepository,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _onboardingSeenCubit),
          BlocProvider.value(value: _themeCubit),
          BlocProvider.value(value: _authBloc)
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
