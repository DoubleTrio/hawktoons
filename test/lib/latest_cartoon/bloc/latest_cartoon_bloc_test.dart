import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/latest_cartoon/latest_cartoon.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../mocks.dart';

void main() {
  group('LatestCartoonBloc', () {
    late FirestorePoliticalCartoonRepository cartoonRepository;
    final politicalCartoon = MockPoliticalCartoon();

    setUp(() {
      cartoonRepository = MockCartoonRepository();
    });

    tearDown(() => reset(cartoonRepository));

    test('initial state is DailyCartoonInProgress()', () {
      expect(
        LatestCartoonBloc(cartoonRepository: cartoonRepository)
          .state,
        equals(const DailyCartoonInProgress()),
      );
    });

    blocTest<LatestCartoonBloc, LatestCartoonState>(
      'Emits [DailyCartoonLoaded(latestCartoon: $politicalCartoon)] '
      'when LoadLatestCartoon is added',
      build: () {
        when(cartoonRepository.getLatestPoliticalCartoon)
          .thenAnswer((_) => Stream.fromIterable([politicalCartoon]));
        return LatestCartoonBloc(
          cartoonRepository: cartoonRepository
        );
      },
      act: (bloc) => bloc.add(const LoadLatestCartoon()),
      expect: () => [DailyCartoonLoaded(politicalCartoon)],
      verify: (_) =>
        verify(cartoonRepository.getLatestPoliticalCartoon).called(1),
      );

    blocTest<LatestCartoonBloc, LatestCartoonState>(
      'Emits [DailyCartoonFailed(\'Error\')] '
      'when LoadLatestCartoon throws a stream error',
      build: () {
        when(cartoonRepository.getLatestPoliticalCartoon).thenAnswer(
          (_) => Stream.error('Error')
        );
        return LatestCartoonBloc(cartoonRepository: cartoonRepository);
      },
      act: (bloc) => bloc.add(const LoadLatestCartoon()),
      expect: () => [const DailyCartoonFailed('Error')],
      verify: (_) =>
        verify(cartoonRepository.getLatestPoliticalCartoon)
          .called(1)
    );

    blocTest<LatestCartoonBloc, LatestCartoonState>(
        'Emits [] when LoadLatestCartoon throws permission denied '
        'FirebaseException',
        build: () {
          when(cartoonRepository.getLatestPoliticalCartoon).thenAnswer(
            (_) => Stream.error(FirebaseException(
              plugin: 'test', code: 'permission-denied'
            ))
          );
          return LatestCartoonBloc(cartoonRepository: cartoonRepository);
        },
        act: (bloc) => bloc.add(const LoadLatestCartoon()),
        expect: () => <LatestCartoonState>[],
        verify: (_) =>
          verify(cartoonRepository.getLatestPoliticalCartoon).called(1),
        );

    blocTest<LatestCartoonBloc, LatestCartoonState>(
        'Emits [DailyCartoonFailed()] when LoadLatestCartoon'
        'throws FirebaseException besides permission-denied',
        build: () {
          when(cartoonRepository.getLatestPoliticalCartoon).thenAnswer(
            (_) => Stream.error(FirebaseException(
              plugin: 'fake-plugin',
              code: 'error-code'
            ))
          );
          return LatestCartoonBloc(cartoonRepository: cartoonRepository);
        },
        act: (bloc) => bloc.add(const LoadLatestCartoon()),
        expect: () => [const DailyCartoonFailed('error-code')],
        verify: (_) =>
          verify(cartoonRepository.getLatestPoliticalCartoon).called(1),
        );
  });
}
