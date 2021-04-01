import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon_bloc.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MockCartoonRepository extends Mock
    implements FirebasePoliticalCartoonRepository {}

void main() {
  group('DailyCartoonBloc', () {
    late FirebasePoliticalCartoonRepository politicalCartoonRepository;
    var mockPoliticalCartoon = PoliticalCartoon(
      id: '2',
      image: 'insert-image-uri-another',
      author: 'Bob',
      date: Timestamp.now(),
      description: 'Another Mock Political Cartoon'
    );


    setUpAll(() => {
      politicalCartoonRepository = MockCartoonRepository(),
    });

    test('initial state is DailyCartoonInProgress()', () {
      var state = DailyCartoonInProgress();
      expect(DailyCartoonBloc(
        dailyCartoonRepository: politicalCartoonRepository).state,
        equals(state));
    });

    blocTest<DailyCartoonBloc, DailyCartoonState>(
        'Emits [DailyCartoonLoaded(dailyCartoon: $mockPoliticalCartoon)] '
        'when LoadDailyCartoon() is added',
        build: () {
          when(politicalCartoonRepository.getLatestPoliticalCartoon)
              .thenAnswer((_) =>
              Stream.fromIterable([mockPoliticalCartoon]));

          return DailyCartoonBloc(
              dailyCartoonRepository: politicalCartoonRepository);
        },
        act: (bloc) => bloc.add(LoadDailyCartoon()),
        expect: () =>
            [DailyCartoonLoaded(dailyCartoon: mockPoliticalCartoon)],
        verify: (_) => {
            verify(politicalCartoonRepository.getLatestPoliticalCartoon)
            .called(1),
        }
      );
  });
}
