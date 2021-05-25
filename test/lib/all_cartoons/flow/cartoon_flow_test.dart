import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/all_cartoons/view/details_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('CartoonFlow', () {
    late AllCartoonsBloc allCartoonsBloc;
    late SelectCartoonCubit selectCartoonCubit;
    late ScrollHeaderCubit scrollHeaderCubit;

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

      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          cartoons: [mockPoliticalCartoon],
          status: CartoonStatus.success,
        )
      );
      when(() => selectCartoonCubit.state)
        .thenReturn(const SelectPoliticalCartoonState());
      when(() => scrollHeaderCubit.state).thenReturn(false);
    });

    testWidgets('shows AllCartoonsPage', (tester) async {
      await tester.pumpApp(
        const CartoonFlow(),
        allCartoonsBloc: allCartoonsBloc,
        selectCartoonCubit: selectCartoonCubit,
        scrollHeaderCubit: scrollHeaderCubit,
      );
      expect(find.byType(AllCartoonsView), findsOneWidget);
    });

    testWidgets('shows DetailsPage', (tester) async {
      when(() => selectCartoonCubit.state).thenReturn(
        SelectPoliticalCartoonState(cartoon: mockPoliticalCartoon)
      );

      await tester.pumpApp(
        const CartoonFlow(),
        allCartoonsBloc: allCartoonsBloc,
        selectCartoonCubit: selectCartoonCubit,
        scrollHeaderCubit: scrollHeaderCubit,
      );

      expect(find.byType(DetailsView), findsOneWidget);
    });

    testWidgets('transitions to DetailsPage', (tester) async {
      await tester.pumpApp(
        const CartoonFlow(),
        allCartoonsBloc: allCartoonsBloc,
        selectCartoonCubit: selectCartoonCubit,
        scrollHeaderCubit: scrollHeaderCubit,
      );
      await tester.tap(find.byType(CartoonCard).first);
      verify(() => selectCartoonCubit.selectCartoon(mockPoliticalCartoon))
        .called(1);
    });
  });
}
