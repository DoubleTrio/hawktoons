import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:hawktoons/widgets/widgets.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('CartoonFlow', () {
    late AllCartoonsBloc allCartoonsBloc;
    late AuthenticationBloc authenticationBloc;
    late SelectCartoonCubit selectCartoonCubit;
    late ScrollHeaderCubit scrollHeaderCubit;

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<SelectPoliticalCartoonState>(
        FakeSelectPoliticalCartoonState()
      );
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      authenticationBloc = MockAuthenticationBloc();
      selectCartoonCubit = MockSelectCartoonCubit();
      scrollHeaderCubit = MockScrollHeaderCubit();

      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial(view: CartoonView.staggered).copyWith(
          cartoons: [mockPoliticalCartoon],
          status: CartoonStatus.success,
        )
      );
      when(() => selectCartoonCubit.state)
        .thenReturn(const SelectPoliticalCartoonState());
      when(() => scrollHeaderCubit.state).thenReturn(false);
      when(() => authenticationBloc.state).thenReturn(
        const AuthenticationState(status: AuthenticationStatus.authenticated)
      );
    });

    testWidgets('shows AllCartoonsPage', (tester) async {
      await tester.pumpApp(
        const CartoonFlow(),
        allCartoonsBloc: allCartoonsBloc,
        authenticationBloc: authenticationBloc,
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
        authenticationBloc: authenticationBloc,
        selectCartoonCubit: selectCartoonCubit,
        scrollHeaderCubit: scrollHeaderCubit,
      );

      expect(find.byType(DetailsView), findsOneWidget);
    });

    testWidgets('transitions to DetailsPage', (tester) async {
      await tester.pumpApp(
        const CartoonFlow(),
        allCartoonsBloc: allCartoonsBloc,
        authenticationBloc: authenticationBloc,
        selectCartoonCubit: selectCartoonCubit,
        scrollHeaderCubit: scrollHeaderCubit,
      );
      await tester.tap(find.byType(StaggeredCartoonCard).first);
      verify(() => selectCartoonCubit.selectCartoon(mockPoliticalCartoon))
        .called(1);
    });
  });
}
