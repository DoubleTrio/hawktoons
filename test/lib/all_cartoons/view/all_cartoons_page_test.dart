import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('AllCartoonsPage', () {
    late AllCartoonsBloc allCartoonsBloc;
    late DailyCartoonBloc dailyCartoonBloc;
    late AuthenticationBloc authenticationBloc;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late ScrollHeaderCubit scrollHeaderCubit;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: dailyCartoonBloc),
        BlocProvider.value(value: authenticationBloc),
        BlocProvider.value(value: showBottomSheetCubit),
        BlocProvider.value(value: scrollHeaderCubit),
      ], child: child);
    }

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
      registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      dailyCartoonBloc = MockDailyCartoonBloc();
      authenticationBloc = MockAuthenticationBloc();
      showBottomSheetCubit = MockShowBottomSheetCubit();
      scrollHeaderCubit = MockScrollHeaderCubit();
      when(() => scrollHeaderCubit.state).thenReturn(false);
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        when(() => allCartoonsBloc.state).thenReturn(
          const AllCartoonsState.initial().copyWith(
            status: CartoonStatus.success,
            cartoons: [mockPoliticalCartoon],
          )
        );
        await mockNetworkImagesFor(
          () => tester.pumpApp(wrapper(const AllCartoonsView())),
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        when(() => allCartoonsBloc.state).thenReturn(
          const AllCartoonsState.initial().copyWith(
            status: CartoonStatus.success,
            cartoons: [mockPoliticalCartoon],
          )
        );
        await mockNetworkImagesFor(
          () => tester.pumpApp(
            wrapper(const AllCartoonsView()),
            mode: ThemeMode.dark,
          ),
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets(
      'renders widget '
      'with Key(\'AllCartoonsPage_AllCartoonsLoading\') '
      'when state is AllCartoonsLoading', (tester) async {
      when(() => allCartoonsBloc.state)
        .thenReturn(const AllCartoonsState.initial());
      await tester.pumpApp(wrapper(const AllCartoonsView()));
      expect(find.byKey(allCartoonsLoadingKey), findsOneWidget);
    });

    testWidgets(
      'renders a cartoon'
      'when status is CartoonStatus.success', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: [mockPoliticalCartoon],
        )
      );

      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(const AllCartoonsView())),
      );
      expect(find.byType(CartoonCard), findsOneWidget);
    });

    testWidgets(
      'renders widget '
      'with Key(\'AllCartoonsPage_AllCartoonsFailed\'); '
      'when state is AllCartoonFailed', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.failure,
        )
      );

      await tester.pumpApp(wrapper(const AllCartoonsView()));
      expect(find.byKey(allCartoonsFailedKey), findsOneWidget);
    });

    testWidgets(
      'opens bottom sheet when filter icon is pressed', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          cartoons: [mockPoliticalCartoon]
        ),
      );
      await tester.pumpApp(wrapper(const AllCartoonsView()));
      await tester.tap(find.byKey(filterButtonKey));
      verify(showBottomSheetCubit.openSheet).called(1);
    });

    testWidgets(
      'logs out when logout button is pressed', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          cartoons: [mockPoliticalCartoon]
        ),
      );
      await tester.pumpApp(wrapper(const AllCartoonsView()));
      await tester.tap(find.byKey(filterLogoutButtonKey));
      verify(allCartoonsBloc.close).called(1);
      verify(dailyCartoonBloc.close).called(1);
      verify(() => authenticationBloc.add(const Logout())).called(1);
    });

    testWidgets(
      'shows SnackBar when new filter is applied', (tester) async {
      whenListen<AllCartoonsState>(allCartoonsBloc,
        Stream.value(
          const AllCartoonsState.initial().copyWith(
            filters: const CartoonFilters.initial().copyWith(
              tag: Tag.worldHistory
            )
          )
        ),
        initialState: const AllCartoonsState.initial(),
      );

      await tester.pumpApp(wrapper(const AllCartoonsView()));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Filter applied!'), findsOneWidget);
    });

    testWidgets(
        'does not show SnackBar when old filter is applied', (tester) async {
      whenListen<AllCartoonsState>(allCartoonsBloc,
        Stream.value(const AllCartoonsState.initial()),
        initialState: const AllCartoonsState.initial(),
      );

      await tester.pumpApp(wrapper(const AllCartoonsView()));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(SnackBar), findsNothing);
    });
  });
}
