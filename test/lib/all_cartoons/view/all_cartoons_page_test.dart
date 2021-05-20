import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('AllCartoonsPage', () {
    late AllCartoonsBloc allCartoonsBloc;
    late AuthenticationBloc authenticationBloc;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late ScrollHeaderCubit scrollHeaderCubit;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: authenticationBloc),
        BlocProvider.value(value: showBottomSheetCubit),
        BlocProvider.value(value: scrollHeaderCubit),
      ], child: child);
    }

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      authenticationBloc = MockAuthenticationBloc();
      showBottomSheetCubit = MockShowBottomSheetCubit();
      scrollHeaderCubit = MockScrollHeaderCubit();
      when(() => scrollHeaderCubit.state).thenReturn(false);
    });

    testWidgets(
      'renders widget '
      'with Key(\'AllCartoonsPage_FilteredCartoonsLoading\') '
      'when state is FilteredCartoonsLoading', (tester) async {
      when(() => allCartoonsBloc.state)
        .thenReturn(const AllCartoonsState.initial());
      await tester.pumpApp(wrapper(const FilteredCartoonsScreen()));
      expect(find.byKey(allCartoonsLoadingKey), findsOneWidget);
    });

    testWidgets(
      'renders widget with '
      'Key(\'AllCartoonsPage_FilteredCartoonsLoaded\') '
      'when state is FilteredCartoonsLoaded', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: [mockPoliticalCartoon],
        )
      );

      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(const FilteredCartoonsScreen())),
      );
      expect(find.byKey(allCartoonsLoadedKey), findsOneWidget);
    });

    testWidgets(
      'renders widget '
      'with Key(\'AllCartoonsPage_FilteredCartoonsFailed\'); '
      'when state is FilteredCartoonFailed', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.failure,
        )
      );

      await tester.pumpApp(wrapper(const FilteredCartoonsScreen()));
      expect(find.byKey(allCartoonsFailedKey), findsOneWidget);
    });

    testWidgets(
      'opens bottom sheet when filter icon is pressed', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          cartoons: [mockPoliticalCartoon]
        ),
      );
      await tester.pumpApp(wrapper(const FilteredCartoonsScreen()));
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
      await tester.pumpApp(wrapper(const FilteredCartoonsScreen()));
      await tester.tap(find.byKey(filterLogoutButtonKey));
      verify(() => authenticationBloc.add(Logout())).called(1);
    });
  });
}
