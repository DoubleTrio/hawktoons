import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/all_cartoons/view/details_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('CartoonFlow', () {
    late AllCartoonsBloc allCartoonsBloc;
    late SelectCartoonCubit selectCartoonCubit;
    late ScrollHeaderCubit scrollHeaderCubit;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: selectCartoonCubit),
        BlocProvider.value(value: scrollHeaderCubit),
      ], child: child);
    }

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<SelectPoliticalCartoonState>(
        FakeSelectPoliticalCartoonState()
      );
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      selectCartoonCubit = MockSelectCartoonCubit();
      scrollHeaderCubit = MockScrollHeaderCubit();
      when(() => scrollHeaderCubit.state).thenReturn(false);
    });

    testWidgets('shows AllCartoonsPage', (tester) async {
      when(() => allCartoonsBloc.state)
        .thenReturn(const AllCartoonsState.initial()
      );
      when(() => selectCartoonCubit.state)
        .thenReturn(const SelectPoliticalCartoonState()
      );

      await tester.pumpApp(wrapper(const CartoonFlow()));
      expect(find.byType(AllCartoonsView), findsOneWidget);
    });

    testWidgets('shows DetailsPage', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: [mockPoliticalCartoon]
        )
      );

      when(() => selectCartoonCubit.state).thenReturn(
        SelectPoliticalCartoonState(cartoon: mockPoliticalCartoon)
      );

      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(const CartoonFlow())),
      );

      expect(find.byType(DetailsView), findsOneWidget);
    });

    testWidgets('transitions to DetailsPage', (tester) async {
      when(() => selectCartoonCubit.state)
        .thenReturn(const SelectPoliticalCartoonState());
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          cartoons: [mockPoliticalCartoon],
          status: CartoonStatus.success,
        )
      );

      await tester.pumpApp(wrapper(const CartoonFlow()));

      await tester.tap(find.byType(CartoonCard).first);

      verify(() => selectCartoonCubit.selectCartoon(mockPoliticalCartoon))
        .called(1);
    });
  });
}
