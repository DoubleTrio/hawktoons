import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/auth/flow/auth_flow.dart';
import 'package:history_app/auth/view/login_page.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/home/home.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('AuthFlow', () {
    late FirestorePoliticalCartoonRepository cartoonRepository;
    late AllCartoonsBloc allCartoonsBloc;
    late DailyCartoonBloc dailyCartoonBloc;
    late AuthenticationBloc authenticationBloc;

    PoliticalCartoon mockCartoon = MockPoliticalCartoon();

    Widget wrapper(Widget child) {
      return RepositoryProvider(
        create: (context) => cartoonRepository,
        child: MultiBlocProvider(providers: [
          BlocProvider.value(value: allCartoonsBloc),
          BlocProvider.value(value: dailyCartoonBloc),
          BlocProvider.value(value: authenticationBloc),
        ], child: child),
      );
    }

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
      registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    });

    setUp(() {
      cartoonRepository = MockPoliticalCartoonRepository();
      allCartoonsBloc = MockAllCartoonsBloc();
      dailyCartoonBloc = MockDailyCartoonBloc();
      authenticationBloc = MockAuthenticationBloc();
      when(() => cartoonRepository.politicalCartoons(
        sortByMode: SortByMode.latestPosted,
        imageType: ImageType.all,
        tag: Tag.all,
        limit: 15,
      )).thenAnswer((_) async => [mockPoliticalCartoon]);
      when(cartoonRepository.getLatestPoliticalCartoon).thenAnswer(
        (_) => Stream.value(mockCartoon)
      );
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial()
      );
      when(() => dailyCartoonBloc.state).thenReturn(
        const DailyCartoonInProgress()
      );
    });

    group('LoginPage', () {
      testWidgets('shows LoginPage', (tester) async {
        when(() => authenticationBloc.state).thenReturn(const Uninitialized());
        await tester.pumpApp(wrapper(const AuthFlow()));
        expect(find.byType(LoginView), findsOneWidget);
      });
    });

    group('HomeFlow', () {
      testWidgets('shows HomeFlow', (tester) async {
        when(() => authenticationBloc.state)
          .thenReturn(const Authenticated('user-id'));
        await tester.pumpApp(wrapper(const AuthFlow()));
        expect(find.byType(HomeFlow), findsOneWidget);
      });
    });
  });
}
