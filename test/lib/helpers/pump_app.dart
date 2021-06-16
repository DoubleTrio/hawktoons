import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/latest_cartoon/bloc/latest_cartoon.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:image_repository/image_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../fakes.dart';
import '../mocks.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    ThemeMode? mode,
    FirestorePoliticalCartoonRepository? cartoonRepository,
    CartoonImageRepository? imageRepository,
    UserRepository? userRepository,
    AllCartoonsBloc? allCartoonsBloc,
    AllCartoonsPageCubit? allCartoonsPageCubit,
    AppDrawerCubit? appDrawerCubit,
    AppearancesCubit? appearancesCubit,
    AuthenticationBloc? authenticationBloc,
    CreateCartoonSheetBloc? createCartoonSheetBloc,
    LatestCartoonBloc? latestCartoonBloc,
    FilterSheetCubit? filterSheetCubit,
    OnboardingCubit? onboardingCubit,
    SettingsScreenCubit? settingsScreenCubit,
    TabBloc? tabBloc,
  }) {
    registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
    registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
    registerFallbackValue<AllCartoonsPageState>(FakeAllCartoonsPageState());
    registerFallbackValue<AppearancesState>(FakeAppearancesState());
    registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    registerFallbackValue<CreateCartoonSheetState>(
      FakeCreateCartoonSheetState()
    );
    registerFallbackValue<CreateCartoonSheetEvent>(
        FakeCreateCartoonSheetEvent()
    );
    registerFallbackValue<LatestCartoonState>(FakeLatestCartoonState());
    registerFallbackValue<LatestCartoonEvent>(FakeLatestCartoonEvent());
    registerFallbackValue<SelectPoliticalCartoonState>(
      FakeSelectPoliticalCartoonState()
    );
    registerFallbackValue<TabEvent>(FakeTabEvent());
    registerFallbackValue<AppTab>(AppTab.latest);
    registerFallbackValue<SettingsScreen>(SettingsScreen.main);
    registerFallbackValue<CartoonFilters>(FakeCartoonFilters());
    registerFallbackValue<OnboardingState>(FakeOnboardingState());
    registerFallbackValue<CreateCartoonPage>(CreateCartoonPage.uploadImage);

    return mockNetworkImagesFor(() async {
      final primary = PrimaryColor.purple;
      return pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(
              value: cartoonRepository ?? MockCartoonRepository()
            ),
            RepositoryProvider.value(
              value: imageRepository ?? MockImageRepository()
            ),
            RepositoryProvider.value(
              value: userRepository ?? MockFirebaseUserRepository()
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: allCartoonsBloc ?? MockAllCartoonsBloc()
              ),
              BlocProvider.value(
                value: allCartoonsPageCubit ?? MockAllCartoonsPageCubit()
              ),
              BlocProvider.value(
                value: appDrawerCubit ?? MockAppDrawerCubit()
              ),
              BlocProvider.value(
                value: appearancesCubit ?? MockAppearancesCubit()
              ),
              BlocProvider.value(
                value: authenticationBloc ?? MockAuthenticationBloc()
              ),
              BlocProvider.value(
                value: createCartoonSheetBloc ?? MockCreateCartoonSheetBloc()
              ),
              BlocProvider.value(
                value: filterSheetCubit ?? MockFiltersCubit()
              ),
              BlocProvider.value(
                value: latestCartoonBloc ?? MockLatestCartoonBloc()
              ),
              BlocProvider.value(
                value: onboardingCubit ?? MockOnboardingCubit()
              ),
              BlocProvider.value(
                value: settingsScreenCubit ?? MockSettingsScreenCubit()
              ),
              BlocProvider.value(value: tabBloc ?? MockTabBloc()),
            ],
            child: MaterialApp(
              theme: createLightTheme(primary),
              darkTheme: createDarkTheme(primary),
              themeMode: mode ?? ThemeMode.light,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: Scaffold(body: widget),
            ),
          ),
        ),
      );
    });
  }
}
