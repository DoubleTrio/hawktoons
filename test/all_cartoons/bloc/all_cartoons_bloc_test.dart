import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockCartoonRepository extends Mock
    implements FirestorePoliticalCartoonRepository {}

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('AllCartoonsBloc', () {
    late FirestorePoliticalCartoonRepository cartoonRepository;
    var politicalCartoons = [MockPoliticalCartoon()];

    setUpAll(() => {
          cartoonRepository = MockCartoonRepository(),
        });

    test('initial state is AllCartoonsLoading', () {
      var state = AllCartoonsLoading();
      expect(AllCartoonsBloc(cartoonRepository: cartoonRepository).state,
          equals(state));
    });

    blocTest<AllCartoonsBloc, AllCartoonsState>(
      'Emits [AllCartoonsLoaded(cartoons: $politicalCartoons)] '
      'when LoadAllCartoons is added',
      build: () {
        when(cartoonRepository.politicalCartoons)
            .thenAnswer((_) => Stream.value(politicalCartoons));

        return AllCartoonsBloc(cartoonRepository: cartoonRepository);
      },
      act: (bloc) => bloc.add(LoadAllCartoons()),
      expect: () => [AllCartoonsLoaded(cartoons: politicalCartoons)],
      verify: (_) => verify(cartoonRepository.politicalCartoons).called(1),
    );

    blocTest<AllCartoonsBloc, AllCartoonsState>(
        'Emits [DailyCartoonFailed(\'Error\')] '
        'when LoadAllCartoons throws a stream error',
        build: () {
          when(cartoonRepository.politicalCartoons)
              .thenAnswer((_) => Stream.error('Error'));

          return AllCartoonsBloc(cartoonRepository: cartoonRepository);
        },
        act: (bloc) => bloc.add(LoadAllCartoons()),
        expect: () => [AllCartoonsFailed('Error')],
        verify: (_) => verify(cartoonRepository.politicalCartoons).called(1));
  });
}
