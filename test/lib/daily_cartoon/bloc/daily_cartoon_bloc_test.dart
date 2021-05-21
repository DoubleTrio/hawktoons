import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../mocks.dart';

void main() {
  group('DailyCartoonBloc', () {
    late FirestorePoliticalCartoonRepository cartoonRepository;
    final politicalCartoon = MockPoliticalCartoon();

    setUp(() {
      cartoonRepository = MockPoliticalCartoonRepository();
    });

    tearDown(() => reset(cartoonRepository));

    test('initial state is DailyCartoonInProgress()', () {
      expect(
        DailyCartoonBloc(dailyCartoonRepository: cartoonRepository)
          .state,
        equals(const DailyCartoonInProgress()),
      );
    });

    blocTest<DailyCartoonBloc, DailyCartoonState>(
      'Emits [DailyCartoonLoaded(dailyCartoon: $politicalCartoon)] '
      'when LoadDailyCartoon is added',
      build: () {
        when(cartoonRepository.getLatestPoliticalCartoon)
          .thenAnswer((_) => Stream.fromIterable([politicalCartoon]));
        return DailyCartoonBloc(
          dailyCartoonRepository: cartoonRepository
        );
      },
      act: (bloc) => bloc.add(const LoadDailyCartoon()),
      expect: () => [DailyCartoonLoaded(politicalCartoon)],
      verify: (_) =>
        verify(cartoonRepository.getLatestPoliticalCartoon).called(1),
      );

    blocTest<DailyCartoonBloc, DailyCartoonState>(
      'Emits [DailyCartoonFailed(\'Error\')] '
      'when LoadDailyCartoon throws a stream error',
      build: () {
        when(cartoonRepository.getLatestPoliticalCartoon).thenAnswer(
          (_) => Stream.error('Error')
        );
        return DailyCartoonBloc(dailyCartoonRepository: cartoonRepository);
      },
      act: (bloc) => bloc.add(const LoadDailyCartoon()),
      expect: () => [const DailyCartoonFailed('Error')],
      verify: (_) =>
        verify(cartoonRepository.getLatestPoliticalCartoon)
          .called(1)
    );

    blocTest<DailyCartoonBloc, DailyCartoonState>(
        'Emits [] when LoadDailyCartoon throws permission denied '
        'FirebaseException',
        build: () {
          when(cartoonRepository.getLatestPoliticalCartoon).thenAnswer(
            (_) => Stream.error(FirebaseException(
              plugin: 'test', code: 'permission-denied'
            ))
          );
          return DailyCartoonBloc(dailyCartoonRepository: cartoonRepository);
        },
        act: (bloc) => bloc.add(const LoadDailyCartoon()),
        expect: () => <DailyCartoonState>[],
        verify: (_) =>
          verify(cartoonRepository.getLatestPoliticalCartoon).called(1),
        );

    blocTest<DailyCartoonBloc, DailyCartoonState>(
        'Emits [DailyCartoonFailed()] when LoadDailyCartoon'
        'throws FirebaseException besides permission-denied',
        build: () {
          when(cartoonRepository.getLatestPoliticalCartoon).thenAnswer(
            (_) => Stream.error(FirebaseException(
              plugin: 'fake-plugin',
              code: 'error-code'
            ))
          );
          return DailyCartoonBloc(dailyCartoonRepository: cartoonRepository);
        },
        act: (bloc) => bloc.add(const LoadDailyCartoon()),
        expect: () => [const DailyCartoonFailed('error-code')],
        verify: (_) =>
          verify(cartoonRepository.getLatestPoliticalCartoon).called(1),
        );
  });
}
