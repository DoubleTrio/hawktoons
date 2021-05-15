import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../../mocks.dart';

void main() {
  group('AllCartoonsBloc', () {
    late FirestorePoliticalCartoonRepository cartoonRepository;

    setUpAll(() {
      cartoonRepository = MockPoliticalCartoonRepository();
    });

    test('initial state is AllCartoonsLoading', () {
      var state = AllCartoonsLoading();
      expect(AllCartoonsBloc(cartoonRepository: cartoonRepository).state,
          equals(state));
    });

    blocTest<AllCartoonsBloc, AllCartoonsState>(
        'Emits [AllCartoonsLoaded] '
        'when LoadAllCartoons is added',
        build: () {
          when(() => cartoonRepository.politicalCartoons(
                  sortByMode: SortByMode.latestPosted))
              .thenAnswer((_) => Stream.value([mockPoliticalCartoon]));

          return AllCartoonsBloc(cartoonRepository: cartoonRepository);
        },
        act: (bloc) => bloc.add(LoadAllCartoons(SortByMode.latestPosted)),
        expect: () => [AllCartoonsLoaded(cartoons: [mockPoliticalCartoon])],
        verify: (_) => verify(() => cartoonRepository.politicalCartoons(
          sortByMode: SortByMode.latestPosted)).called(1)
        );

    blocTest<AllCartoonsBloc, AllCartoonsState>(
        'Emits [DailyCartoonFailed(\'Error\')] '
        'when LoadAllCartoons throws a stream error',
        build: () {
          when(() => cartoonRepository.politicalCartoons(
            sortByMode: SortByMode.latestPosted)
          ).thenAnswer((_) => Stream.error('Error'));
          return AllCartoonsBloc(cartoonRepository: cartoonRepository);
        },
        act: (bloc) => bloc.add(LoadAllCartoons(SortByMode.latestPosted)),
        expect: () => [AllCartoonsFailed('Error')],
        verify: (_) => verify(() => cartoonRepository.politicalCartoons(
          sortByMode: SortByMode.latestPosted)
        ).called(1)
    );
  });
}
