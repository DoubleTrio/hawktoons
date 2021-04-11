import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockCartoonRepository extends Mock
    implements FirestorePoliticalCartoonRepository {}

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('DailyCartoonBloc', () {
    late FirestorePoliticalCartoonRepository politicalCartoonRepository;
    var politicalCartoon = MockPoliticalCartoon();

    setUpAll(() => {
          politicalCartoonRepository = MockCartoonRepository(),
        });

    test('initial state is DailyCartoonInProgress()', () {
      var state = DailyCartoonInProgress();
      expect(
          DailyCartoonBloc(dailyCartoonRepository: politicalCartoonRepository)
              .state,
          equals(state));
    });

    blocTest<DailyCartoonBloc, DailyCartoonState>(
        'Emits [DailyCartoonLoaded(dailyCartoon: $politicalCartoon)] '
        'when LoadDailyCartoon is added',
        build: () {
          when(politicalCartoonRepository.getLatestPoliticalCartoon)
              .thenAnswer((_) => Stream.fromIterable([politicalCartoon]));

          return DailyCartoonBloc(
              dailyCartoonRepository: politicalCartoonRepository);
        },
        act: (bloc) => bloc.add(LoadDailyCartoon()),
        expect: () => [DailyCartoonLoaded(dailyCartoon: politicalCartoon)],
        verify: (_) => {
              verify(politicalCartoonRepository.getLatestPoliticalCartoon)
                  .called(1),
            });

    blocTest<DailyCartoonBloc, DailyCartoonState>(
        'Emits [DailyCartoonFailed(\'Error\')] '
        'when LoadDailyCartoon throws a stream error',
        build: () {
          when(politicalCartoonRepository.getLatestPoliticalCartoon)
              .thenAnswer((_) => Stream.error('Error'));

          return DailyCartoonBloc(
              dailyCartoonRepository: politicalCartoonRepository);
        },
        act: (bloc) => bloc.add(LoadDailyCartoon()),
        expect: () => [DailyCartoonFailed('Error')],
        verify: (_) => {
              verify(politicalCartoonRepository.getLatestPoliticalCartoon)
                  .called(1),
            });
  });
}
