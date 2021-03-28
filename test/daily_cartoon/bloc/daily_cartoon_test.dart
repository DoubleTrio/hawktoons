import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon_bloc.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';

import 'package:mocktail/mocktail.dart';

class MockCartoonRepository extends Mock
    implements FirebaseDailyCartoonRepository {}

void main() {
  group('DailyCartoonBloc', () {
    late DailyCartoonRepository dailyCartoonRepository;
    var mockDailyPoliticalCartoon = DailyCartoon(
        id: '2',
        image: 'insert-image-uri-another',
        author: 'Bob',
        date: '11-20-2020',
        description: 'Another Mock Political Cartoon');

    setUpAll(() => {
          dailyCartoonRepository = MockCartoonRepository(),
        });

    test('initial state is DailyCartoonInProgress()', () {
      expect(
          DailyCartoonBloc(dailyCartoonRepository: dailyCartoonRepository)
              .state,
          equals(DailyCartoonInProgress()));
    });

    blocTest<DailyCartoonBloc, DailyCartoonState>(
        'Emits [DailyCartoonLoaded(dailyCartoon: $mockDailyPoliticalCartoon)] '
        'when LoadDailyCartoon() is added',
        build: () {
          when(dailyCartoonRepository.fetchDailyCartoon)
              .thenAnswer((_) async => mockDailyPoliticalCartoon);

          return DailyCartoonBloc(
              dailyCartoonRepository: dailyCartoonRepository);
        },
        act: (bloc) => bloc.add(LoadDailyCartoon()),
        expect: () =>
            [DailyCartoonLoaded(dailyCartoon: mockDailyPoliticalCartoon)],
        verify: (_) => {
              verify(() => dailyCartoonRepository.fetchDailyCartoon())
                  .called(1),
            });

    blocTest<DailyCartoonBloc, DailyCartoonState>(
        'Emits [DailyCartoonFailure()] '
        'when error is thrown in LoadDailyCartoon',
        build: () {
          when(dailyCartoonRepository.fetchDailyCartoon)
              .thenAnswer((_) async => throw Exception('Error'));
          return DailyCartoonBloc(
              dailyCartoonRepository: dailyCartoonRepository);
        },
        act: (bloc) => bloc.add(LoadDailyCartoon()),
        expect: () => [DailyCartoonFailure()],
        verify: (_) => {
              verify(() => dailyCartoonRepository.fetchDailyCartoon())
                  .called(1),
            });
  });
}
