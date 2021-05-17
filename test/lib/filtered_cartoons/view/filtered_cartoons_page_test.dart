import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('FilteredCartoonsPage', () {
    late AllCartoonsBloc allCartoonsBloc;
    late TagCubit tagCubit;
    late SortByCubit sortByCubit;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late AuthenticationBloc authenticationBloc;
    late ScrollHeaderCubit scrollHeaderCubit;
    late SelectCartoonCubit selectCartoonCubit;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: tagCubit),
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: sortByCubit),
        BlocProvider.value(value: showBottomSheetCubit),
        BlocProvider.value(value: scrollHeaderCubit),
        BlocProvider.value(value: authenticationBloc),
        BlocProvider.value(value: selectCartoonCubit),
      ], child: child);
    }

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<SelectPoliticalCartoonState>(
          SelectPoliticalCartoonState()
      );
      registerFallbackValue<Tag>(Tag.all);
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);

      allCartoonsBloc = MockAllCartoonsBloc();
      tagCubit = MockTagCubit();
      sortByCubit = MockSortByCubit();
      showBottomSheetCubit = MockShowBottomSheetCubit();
      authenticationBloc = MockAuthenticationBloc();
      scrollHeaderCubit = MockScrollHeaderCubit();
      selectCartoonCubit = MockSelectCartoonCubit();
      when(() => scrollHeaderCubit.state).thenReturn(false);
    });

    testWidgets(
      'renders widget '
      'with Key(\'FilteredCartoonsPage_FilteredCartoonsLoading\') '
      'when state is FilteredCartoonsLoading', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial()
      );
      when(() => scrollHeaderCubit.state).thenReturn(false);
      await tester.pumpApp(wrapper(const FilteredCartoonsScreen()));
      expect(find.byKey(filteredCartoonsLoadingKey), findsOneWidget);
    });

    testWidgets(
      'renders widget with '
      'Key(\'FilteredCartoonsPage_FilteredCartoonsLoaded\') '
      'when state is FilteredCartoonsLoaded', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: [mockPoliticalCartoon]
        )
      );

      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(const FilteredCartoonsScreen())),
      );
      expect(find.byKey(filteredCartoonsLoadedKey), findsOneWidget);
    });

    testWidgets(
      'renders widget '
      'with Key(\'FilteredCartoonsPage_FilteredCartoonsFailed\'); '
      'when state is FilteredCartoonFailed', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.failure,
        )
      );

      await tester.pumpApp(wrapper(const FilteredCartoonsScreen()));
      expect(find.byKey(filteredCartoonsFailedKey), findsOneWidget);
    });

    testWidgets('opens bottom sheet '
        'when filter icon is pressed', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          cartoons: [mockPoliticalCartoon]
        )
      );
      await tester.pumpApp(wrapper(const FilteredCartoonsScreen()));
      await tester.tap(find.byKey(filterButtonKey));
      verify(showBottomSheetCubit.openSheet).called(1);
    });

    testWidgets('logs out '
        'when logout button is pressed', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          cartoons: [mockPoliticalCartoon]
        )
      );
      await tester.pumpApp(wrapper(const FilteredCartoonsScreen()));
      await tester.tap(find.byKey(filterLogoutButtonKey));
      verify(() => authenticationBloc.add(Logout())).called(1);
    });
  });
}