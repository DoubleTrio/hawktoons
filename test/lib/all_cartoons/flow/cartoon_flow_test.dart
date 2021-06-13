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
    late AllCartoonsPageCubit allCartoonsPageCubit;
    late AuthenticationBloc authenticationBloc;

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<AllCartoonsPageState>(FakeAllCartoonsPageState());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<SelectPoliticalCartoonState>(
        FakeSelectPoliticalCartoonState()
      );
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      allCartoonsPageCubit = MockAllCartoonsPageCubit();
      authenticationBloc = MockAuthenticationBloc();

      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial(view: CartoonView.staggered).copyWith(
          cartoons: [mockPoliticalCartoon],
          status: CartoonStatus.success,
        )
      );
      when(() => allCartoonsPageCubit.state).thenReturn(
        const AllCartoonsPageState.initial()
      );
      when(() => authenticationBloc.state).thenReturn(
        const AuthenticationState(status: AuthenticationStatus.authenticated)
      );
    });

    testWidgets('shows AllCartoonsPage', (tester) async {
      await tester.pumpApp(
        const CartoonFlow(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
      );
      expect(find.byType(AllCartoonsView), findsOneWidget);
    });

    testWidgets('shows DetailsPage', (tester) async {
      when(() => allCartoonsPageCubit.state).thenReturn(
        const AllCartoonsPageState.initial().copyWith(
          politicalCartoon: SelectPoliticalCartoonState(
            cartoon: mockPoliticalCartoon
          )
        )
      );
      await tester.pumpApp(
        const CartoonFlow(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
      );

      expect(find.byType(DetailsView), findsOneWidget);
    });

    testWidgets('transitions to DetailsPage', (tester) async {
      await tester.pumpApp(
        const CartoonFlow(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
      );
      await tester.tap(find.byType(StaggeredCartoonCard).first);
      verify(() => allCartoonsPageCubit.selectCartoon(mockPoliticalCartoon))
        .called(1);
    });
  });
}
