import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('StaggeredCartoonGrid', () {
    late SelectCartoonCubit selectCartoonCubit;
    late ScrollHeaderCubit scrollHeaderCubit;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: selectCartoonCubit),
        BlocProvider.value(value: scrollHeaderCubit),
      ], child: child);
    }

    setUpAll(() async {
      registerFallbackValue<SelectPoliticalCartoonState>(
        SelectPoliticalCartoonState()
      );
      selectCartoonCubit = MockSelectCartoonCubit();
      scrollHeaderCubit = MockScrollHeaderCubit();
      when(() => selectCartoonCubit.state)
        .thenReturn(SelectPoliticalCartoonState());
    });

    testWidgets('sets cartoon', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(
          Column(
            children: [
              StaggeredCartoonGrid(
                cartoons: List.filled(3, mockPoliticalCartoon)
              ),
            ],
          )
        )),
      );
      expect(find.byType(CartoonCard), findsNWidgets(3));

      await tester.tap(
        find.byType(CartoonCard).first,
      );

      verify(() =>
        selectCartoonCubit.selectCartoon(mockPoliticalCartoon)
      ).called(1);
    });

    testWidgets('display scroll header after scrolling', (tester) async {
      await mockNetworkImagesFor(
          () => tester.pumpApp(wrapper(
          Column(
            children: [
              StaggeredCartoonGrid(
                cartoons: List.filled(10, mockPoliticalCartoon)
              ),
            ],
          )
        )),
      );

      await tester.drag(
        find.byType(StaggeredCartoonGrid),
        const Offset(0, -100)
      );

      await tester.drag(
        find.byType(StaggeredCartoonGrid),
        const Offset(0, 100)
      );

      verifyInOrder([
        scrollHeaderCubit.onScrollPastHeader,
        scrollHeaderCubit.onScrollBeforeHeader
      ]);
    });
  });
}