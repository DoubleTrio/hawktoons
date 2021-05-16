import 'package:bloc_test/bloc_test.dart';
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

    test('initial state AllCartoonsLoaded.initial', () {
      var state = const AllCartoonsLoaded.initial();
      expect(
        AllCartoonsBloc(cartoonRepository: cartoonRepository).state,
        equals(state)
      );
    });

    blocTest<AllCartoonsBloc, AllCartoonsLoaded>(
        'Emits [AllCartoonsLoaded] '
        'when LoadAllCartoons is added',
        build: () {
          when(() => cartoonRepository.politicalCartoons(
            sortByMode: SortByMode.latestPosted,
            imageType: ImageType.all,
            tag: Tag.all
          ))
          .thenAnswer((_) => Future.value([mockPoliticalCartoon]));
          return AllCartoonsBloc(cartoonRepository: cartoonRepository);
        },
        act: (bloc) => bloc.add(
          LoadAllCartoons(mockFilter.copyWith(sortByMode: SortByMode.latestPosted))
        ),
        expect: () => [
          const AllCartoonsLoaded.initial(),
          const AllCartoonsLoaded.initial().copyWith(
            cartoons: [mockPoliticalCartoon],
            status: CartoonStatus.success
          )
        ],
        verify: (_) =>
          verify(() => cartoonRepository.politicalCartoons(
            sortByMode: SortByMode.latestPosted,
            imageType: ImageType.all,
            tag: Tag.all
          )).called(1)
        );

    blocTest<AllCartoonsBloc, AllCartoonsLoaded>(
      'Emits [DailyCartoonFailed(\'Error\')] '
      'when LoadAllCartoons throws a stream error',
      build: () {
        when(() => cartoonRepository.politicalCartoons(
          sortByMode: SortByMode.latestPosted,
          imageType: ImageType.all,
          tag: Tag.all
        ))
          .thenAnswer((_) => Future.error('Error'));
        return AllCartoonsBloc(cartoonRepository: cartoonRepository);
      },
      act: (bloc) => bloc.add(LoadAllCartoons(mockFilter)),
      expect: () => [
        const AllCartoonsLoaded.initial(),
        const AllCartoonsLoaded.initial().copyWith(
          status: CartoonStatus.failure
        )
      ],
    );

    blocTest<AllCartoonsBloc, AllCartoonsLoaded>(
      'bloc loads more cartoon and errors',
      build: () {
        when(() => cartoonRepository.loadMorePoliticalCartoons(
          sortByMode: SortByMode.latestPosted,
          imageType: ImageType.all,
          tag: Tag.all
        ))
          .thenAnswer((_) => Future.error('Error'));
        return AllCartoonsBloc(cartoonRepository: cartoonRepository);
      },
      act: (bloc) => bloc.add(LoadMoreCartoons(mockFilter)),
      expect: () => [
        const AllCartoonsLoaded.initial().copyWith(status: CartoonStatus.loading),
        const AllCartoonsLoaded.initial().copyWith(
          status: CartoonStatus.failure
        )
      ],
    );
  });
}
