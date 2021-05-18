import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/all_cartoons/view/details_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('FilteredFlow', () {
    late AllCartoonsBloc allCartoonsBloc;
    late TagCubit tagCubit;
    late SortByCubit sortByCubit;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late AuthenticationBloc authenticationBloc;
    late ScrollHeaderCubit scrollHeaderCubit;
    late SelectCartoonCubit selectCartoonCubit;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: selectCartoonCubit),
        BlocProvider.value(value: tagCubit),
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: sortByCubit),
        BlocProvider.value(value: showBottomSheetCubit),
        BlocProvider.value(value: scrollHeaderCubit),
        BlocProvider.value(value: authenticationBloc),
      ], child: child);
    }

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<SelectPoliticalCartoonState>(
          SelectPoliticalCartoonState());
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

    testWidgets('shows AllCartoonsPage', (tester) async {
      when(() => allCartoonsBloc.state)
          .thenReturn(const AllCartoonsState.initial());
      when(() => selectCartoonCubit.state)
          .thenReturn(SelectPoliticalCartoonState());

      await tester.pumpApp(wrapper(const FilteredFlow()));
      expect(find.byType(FilteredCartoonsScreen), findsOneWidget);
    });

    testWidgets('shows DetailsPage', (tester) async {
      when(() => allCartoonsBloc.state)
          .thenReturn(const AllCartoonsState.initial());

      when(() => selectCartoonCubit.state).thenReturn(
          SelectPoliticalCartoonState(cartoon: mockPoliticalCartoon));

      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(const FilteredFlow())),
      );

      expect(find.byType(DetailsScreen), findsOneWidget);
    });

    testWidgets('transitions to DetailsPage', (tester) async {
      when(() => scrollHeaderCubit.state).thenReturn(false);
      when(() => selectCartoonCubit.state)
          .thenReturn(SelectPoliticalCartoonState());
      when(() => allCartoonsBloc.state)
          .thenReturn(const AllCartoonsState.initial().copyWith(
        cartoons: [mockPoliticalCartoon],
        status: CartoonStatus.success,
      ));

      await tester.pumpApp(wrapper(const FilteredFlow()));

      await tester.tap(find.byType(CartoonCard).first);

      verify(() => selectCartoonCubit.selectCartoon(mockPoliticalCartoon))
          .called(1);
    });
  });
}
