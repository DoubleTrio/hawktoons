import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/latest_cartoon/bloc/latest_cartoon.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:hawktoons/theme/theme.dart';
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
    UserRepository? userRepository,
    AllCartoonsBloc? allCartoonsBloc,
    AppDrawerCubit? appDrawerCubit,
    AuthenticationBloc? authenticationBloc,
    CartoonViewCubit? cartoonViewCubit,
    CreateCartoonPageCubit? createCartoonPageCubit,
    LatestCartoonBloc? latestCartoonBloc,
    ImageTypeCubit? imageTypeCubit,
    OnboardingCubit? onboardingCubit,
    PrimaryColorCubit? primaryColorCubit,
    ScrollHeaderCubit? scrollHeaderCubit,
    SelectCartoonCubit? selectCartoonCubit,
    SettingsScreenCubit? settingsScreenCubit,
    ShowCreateCartoonSheetCubit? showCreateCartoonSheetCubit,
    ShowFilterBottomSheetCubit? showFilterBottomSheetCubit,
    SortByCubit? sortByCubit,
    TagCubit? tagCubit,
    TabBloc? tabBloc,
    ThemeCubit? themeCubit,
  }) {
    registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
    registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
    registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    registerFallbackValue<LatestCartoonState>(FakeLatestCartoonState());
    registerFallbackValue<LatestCartoonEvent>(FakeLatestCartoonEvent());
    registerFallbackValue<SelectPoliticalCartoonState>(
      FakeSelectPoliticalCartoonState()
    );
    registerFallbackValue<TabEvent>(FakeTabEvent());
    registerFallbackValue<AppTab>(AppTab.latest);
    registerFallbackValue<Tag>(Tag.all);
    registerFallbackValue<SettingsScreen>(SettingsScreen.main);
    registerFallbackValue<SortByMode>(SortByMode.latestPosted);
    registerFallbackValue<CartoonView>(CartoonView.card);
    registerFallbackValue<ImageType>(ImageType.all);
    registerFallbackValue<ThemeMode>(ThemeMode.light);
    registerFallbackValue<OnboardingState>(FakeOnboardingState());
    registerFallbackValue<PrimaryColor>(PrimaryColor.purple);
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
              value: userRepository ?? MockFirebaseUserRepository()
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: allCartoonsBloc ?? MockAllCartoonsBloc()
              ),
              BlocProvider.value(
                value: appDrawerCubit ?? MockAppDrawerCubit()
              ),
              BlocProvider.value(
                value: authenticationBloc ?? MockAuthenticationBloc()
              ),
              BlocProvider.value(
                value: cartoonViewCubit ?? MockCartoonViewCubit()
              ),
              BlocProvider.value(
                value: createCartoonPageCubit ?? MockCreateCartoonPageCubit()
              ),
              BlocProvider.value(
                value: imageTypeCubit ?? MockImageTypeCubit()
              ),
              BlocProvider.value(
                value: latestCartoonBloc ?? MockLatestCartoonBloc()
              ),
              BlocProvider.value(
                value: onboardingCubit ?? MockOnboardingCubit()
              ),
              BlocProvider.value(
                value: primaryColorCubit ?? MockPrimaryColorCubit()
              ),
              BlocProvider.value(value: tabBloc ?? MockTabBloc()),
              BlocProvider.value(value: tagCubit ?? MockTagCubit()),
              BlocProvider.value(
                value: scrollHeaderCubit ?? MockScrollHeaderCubit()
              ),
              BlocProvider.value(
                value: selectCartoonCubit ?? MockSelectCartoonCubit()
              ),
              BlocProvider.value(
                value: settingsScreenCubit ?? MockSettingsScreenCubit()
              ),
              BlocProvider.value(
                value: showCreateCartoonSheetCubit
                  ?? MockShowCreateCartoonSheetCubit()
              ),
              BlocProvider.value(
                value: showFilterBottomSheetCubit
                  ?? MockShowBottomFilterSheetCubit()
              ),
              BlocProvider.value(value: sortByCubit ?? MockSortByCubit()),
              BlocProvider.value(value: imageTypeCubit ?? MockImageTypeCubit()),
              BlocProvider.value(value: tabBloc ?? MockTabBloc()),
              BlocProvider.value(value: themeCubit ?? MockThemeCubit()),
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
