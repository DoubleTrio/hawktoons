import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/flow/auth_flow.dart';
import 'package:history_app/auth/view/login_page.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/blocs/tab/models/models.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/home/home_flow.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';


void main() {
  group('AuthFlow', () {
    late TabBloc tabBloc;
    late AllCartoonsBloc allCartoonsBloc;
    late TagCubit tagCubit;
    late SortByCubit sortByCubit;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late DailyCartoonBloc dailyCartoonBloc;
    late FilteredCartoonsBloc filteredCartoonsBloc;
    late ScrollHeaderCubit scrollHeaderCubit;
    late AuthenticationBloc authenticationBloc;
    late FirestorePoliticalCartoonRepository cartoonRepository;

    PoliticalCartoon mockCartoon = MockPoliticalCartoon();

    Widget wrapper(Widget child) {
      return RepositoryProvider(
        create: (context) => cartoonRepository,
        child: MultiBlocProvider(providers: [
          BlocProvider.value(value: tagCubit),
          BlocProvider.value(value: allCartoonsBloc),
          BlocProvider.value(value: sortByCubit),
          BlocProvider.value(value: showBottomSheetCubit),
          BlocProvider.value(value: dailyCartoonBloc),
          BlocProvider.value(value: tabBloc),
          BlocProvider.value(value: filteredCartoonsBloc),
          BlocProvider.value(value: scrollHeaderCubit),
          BlocProvider.value(value: authenticationBloc),
        ], child: child),
      );
    }
    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<FilteredCartoonsState>(FakeFilteredCartoonsState());
      registerFallbackValue<FilteredCartoonsEvent>(FakeFilteredCartoonsEvent());
      registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
      registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<TabEvent>(FakeTabEvent());
      registerFallbackValue<AppTab>(AppTab.daily);
      registerFallbackValue<Tag>(Tag.all);
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);

      tabBloc = MockTabBloc();
      allCartoonsBloc = MockAllCartoonsBloc();
      tagCubit = MockTagCubit();
      sortByCubit = MockSortByCubit();
      showBottomSheetCubit = MockShowBottomSheetCubit();
      dailyCartoonBloc = MockDailyCartoonBloc();
      filteredCartoonsBloc = MockFilteredCartoonsBloc();
      scrollHeaderCubit = MockScrollHeaderCubit();
      authenticationBloc = MockAuthenticationBloc();
      cartoonRepository = MockPoliticalCartoonRepository();

      when(() => allCartoonsBloc.state).thenReturn(AllCartoonsLoading());
      when(() => showBottomSheetCubit.state).thenReturn(false);
      when(() => dailyCartoonBloc.state).thenReturn(DailyCartoonInProgress());
      when(() => filteredCartoonsBloc.state)
        .thenReturn(FilteredCartoonsLoading());
      when(cartoonRepository.getLatestPoliticalCartoon)
        .thenAnswer((_) => Stream.value(mockCartoon));
      when(() => cartoonRepository.politicalCartoons(
        sortByMode: sortByCubit.state
      )).thenAnswer((_) => Stream.value([mockCartoon]));
    });

    group('LoginPage', () {
      testWidgets('shows LoginPage', (tester) async {
        when(() => authenticationBloc.state).thenReturn(Uninitialized());
        await tester.pumpApp(wrapper(AuthFlow()));
        expect(find.byType(LoginScreen), findsOneWidget);
      });
    });

    group('HomeFlow', () {
      testWidgets('shows HomeFlow', (tester) async {
        when(() => sortByCubit.state).thenReturn(SortByMode.latestPublished);
        when(() => authenticationBloc.state)
          .thenReturn(Authenticated('user-id'));
        when(() => scrollHeaderCubit.state).thenReturn(false);
        when(() => allCartoonsBloc.state).thenReturn(
          AllCartoonsLoaded(cartoons: [mockCartoon])
        );

        print(sortByCubit.state);

        await tester.pumpApp(wrapper(AuthFlow()));
        expect(find.byType(HomeFlow), findsOneWidget);

        verify(() => allCartoonsBloc
          .add(LoadAllCartoons(sortByCubit.state))
        ).called(1);
      });
    });
  });
}
