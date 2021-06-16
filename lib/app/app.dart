import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:image_repository/image_repository.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseUserRepository = FirebaseUserRepository();
    final _firebaseCartoonRepository = FirestorePoliticalCartoonRepository();
    final _imageRepository = CartoonImageRepository();

    final _appearancesCubit = AppearancesCubit();
    final _authBloc = AuthenticationBloc(
      userRepository: _firebaseUserRepository
    );
    final _onboardingCubit = OnboardingCubit();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _firebaseCartoonRepository,
        ),
        RepositoryProvider.value(
          value: _firebaseUserRepository,
        ),
        RepositoryProvider.value(
          value: _imageRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _appearancesCubit),
          BlocProvider.value(value: _authBloc),
          BlocProvider.value(value: _onboardingCubit),
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
    final themeMode = context.select<AppearancesCubit, ThemeMode>(
      (bloc) => bloc.state.themeMode
    );

    final primaryColor = context.select<AppearancesCubit, PrimaryColor>(
      (bloc) => bloc.state.primaryColor
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: createLightTheme(primaryColor),
      darkTheme: createDarkTheme(primaryColor),
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
