import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/auth/flow/auth_flow.dart';
import 'package:history_app/auth/view/login_page.dart';
import 'package:history_app/home/home.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('AuthFlow', () {
    late FirestorePoliticalCartoonRepository cartoonRepository;
    late AuthenticationBloc authenticationBloc;

    PoliticalCartoon mockCartoon = MockPoliticalCartoon();

    setUpAll(() {
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    });

    setUp(() {
      cartoonRepository = MockCartoonRepository();
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
    });

    group('LoginPage', () {
      testWidgets('shows LoginPage', (tester) async {
        when(() => authenticationBloc.state).thenReturn(const Uninitialized());
        await tester.pumpApp(
          const AuthFlow(),
          authenticationBloc: authenticationBloc,
        );
        expect(find.byType(LoginView), findsOneWidget);
      });
    });

    group('HomeFlow', () {
      testWidgets('shows HomeFlow', (tester) async {
        when(() => authenticationBloc.state)
          .thenReturn(Authenticated(FakeUser()));
        await tester.pumpApp(
          const AuthFlow(),
          cartoonRepository: cartoonRepository,
          authenticationBloc: authenticationBloc,
        );
        expect(find.byType(HomeFlow), findsOneWidget);
      });
    });
  });
}
