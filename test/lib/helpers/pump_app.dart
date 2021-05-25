import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/home/blocs/blocs.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:history_app/onboarding/cubits/cubits.dart';
import 'package:history_app/onboarding/cubits/onboarding_seen_cubit.dart';
import 'package:history_app/onboarding/models/models.dart';
import 'package:history_app/theme/theme.dart';
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
    AuthenticationBloc? authenticationBloc,
    DailyCartoonBloc? dailyCartoonBloc,
    ImageTypeCubit? imageTypeCubit,
    OnboardingPageCubit? onboardingPageCubit,
    OnboardingSeenCubit? onboardingSeenCubit,
    ScrollHeaderCubit? scrollHeaderCubit,
    SelectCartoonCubit? selectCartoonCubit,
    ShowBottomSheetCubit? showBottomSheetCubit,
    SortByCubit? sortByCubit,
    TagCubit? tagCubit,
    TabBloc? tabBloc,
    ThemeCubit? themeCubit,
  }) {
    registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
    registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
    registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
    registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
    registerFallbackValue<SelectPoliticalCartoonState>(
      FakeSelectPoliticalCartoonState()
    );
    registerFallbackValue<TabEvent>(FakeTabEvent());
    registerFallbackValue<AppTab>(AppTab.daily);
    registerFallbackValue<Tag>(Tag.all);
    registerFallbackValue<SortByMode>(SortByMode.latestPosted);
    registerFallbackValue<ImageType>(ImageType.all);
    registerFallbackValue<ThemeMode>(ThemeMode.light);
    registerFallbackValue<VisibleOnboardingPage>(
      VisibleOnboardingPage.dailyCartoon
    );

    return mockNetworkImagesFor(() async {
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
                value: authenticationBloc ?? MockAuthenticationBloc()
              ),
              BlocProvider.value(
                value: dailyCartoonBloc ?? MockDailyCartoonBloc()
              ),
              BlocProvider.value(
                value: imageTypeCubit ?? MockImageTypeCubit()
              ),
              BlocProvider.value(
                value: selectCartoonCubit ?? MockSelectCartoonCubit()
              ),
              BlocProvider.value(
                value: onboardingPageCubit ?? MockOnboardingPageCubit()
              ),
              BlocProvider.value(
                value: onboardingSeenCubit ?? MockOnboardingSeenCubit()
              ),
              BlocProvider.value(value: tabBloc ?? MockTabBloc()),
              BlocProvider.value(value: tagCubit ?? MockTagCubit()),
              BlocProvider.value(
                value: scrollHeaderCubit ?? MockScrollHeaderCubit()
              ),
              BlocProvider.value(
                value: showBottomSheetCubit ?? MockShowBottomSheetCubit()
              ),
              BlocProvider.value(value: sortByCubit ?? MockSortByCubit()),
              BlocProvider.value(value: imageTypeCubit ?? MockImageTypeCubit()),
              BlocProvider.value(value: tabBloc ?? MockTabBloc()),
              BlocProvider.value(value: themeCubit ?? MockThemeCubit()),
            ],
            child: MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
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
