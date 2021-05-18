import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../../mocks.dart';

void main() {
  final mockCartoon = MockPoliticalCartoon();
  group('AllCartoonsBloc', () {
    late FirestorePoliticalCartoonRepository cartoonRepository;

    setUpAll(() {
      cartoonRepository = MockPoliticalCartoonRepository();
    });

    test('initial state AllCartoonsState.initial', () {
      var state = const AllCartoonsState.initial();
      expect(AllCartoonsBloc(cartoonRepository: cartoonRepository).state,
          equals(state));
    });

    blocTest<AllCartoonsBloc, AllCartoonsState>(
        'loads first set of images with a reached max status',
        build: () {
          when(() => cartoonRepository.politicalCartoons(
                sortByMode: mockFilter.sortByMode,
                imageType: mockFilter.imageType,
                tag: mockFilter.tag,
                limit: 15,
              )).thenAnswer((_) => Future.value([mockCartoon]));
          return AllCartoonsBloc(cartoonRepository: cartoonRepository);
        },
        // wait: ,
        act: (bloc) => bloc.add(LoadAllCartoons(mockFilter)),
        expect: () => <AllCartoonsState>[
              const AllCartoonsState.initial(),
              const AllCartoonsState.initial().copyWith(
                cartoons: [mockCartoon],
                status: CartoonStatus.success,
                hasReachedMax: true,
              )
            ],
        verify: (_) => verify(() => cartoonRepository.politicalCartoons(
              sortByMode: mockFilter.sortByMode,
              imageType: mockFilter.imageType,
              tag: mockFilter.tag,
              limit: 15,
            )).called(1));

    blocTest<AllCartoonsBloc, AllCartoonsState>(
      'loads first set of images with not a reached max status',
      build: () {
        when(() => cartoonRepository.politicalCartoons(
              sortByMode: mockFilter.sortByMode,
              imageType: mockFilter.imageType,
              tag: mockFilter.tag,
              limit: 15,
            )).thenAnswer((_) => Future.value(List.filled(15, mockCartoon)));
        return AllCartoonsBloc(cartoonRepository: cartoonRepository);
      },
      // wait: ,
      act: (bloc) => bloc.add(LoadAllCartoons(mockFilter)),
      expect: () => <AllCartoonsState>[
        const AllCartoonsState.initial(),
        const AllCartoonsState.initial().copyWith(
          cartoons: List.filled(15, mockCartoon),
          status: CartoonStatus.success,
          hasReachedMax: false,
        )
      ],
      verify: (_) => verify(() => cartoonRepository.politicalCartoons(
            sortByMode: mockFilter.sortByMode,
            imageType: mockFilter.imageType,
            tag: mockFilter.tag,
            limit: 15,
          )).called(1),
    );

    blocTest<AllCartoonsBloc, AllCartoonsState>(
      'emits loading for cartoons and throws error',
      build: () {
        when(() => cartoonRepository.politicalCartoons(
              sortByMode: mockFilter.sortByMode,
              imageType: mockFilter.imageType,
              tag: mockFilter.tag,
              limit: 15,
            )).thenThrow(Exception('Error'));
        return AllCartoonsBloc(cartoonRepository: cartoonRepository);
      },
      act: (bloc) => bloc.add(LoadAllCartoons(mockFilter)),
      expect: () => [
        const AllCartoonsState.initial(),
        const AllCartoonsState.initial().copyWith(status: CartoonStatus.failure)
      ],
      verify: (_) => verify(() => cartoonRepository.politicalCartoons(
            sortByMode: mockFilter.sortByMode,
            imageType: mockFilter.imageType,
            tag: mockFilter.tag,
            limit: 15,
          )).called(1),
    );

    blocTest<AllCartoonsBloc, AllCartoonsState>(
      'bloc loads more cartoons and errors',
      build: () {
        when(() => cartoonRepository.loadMorePoliticalCartoons(
              sortByMode: mockFilter.sortByMode,
              imageType: mockFilter.imageType,
              tag: mockFilter.tag,
              limit: 15,
            )).thenThrow(Exception('Error'));
        return AllCartoonsBloc(cartoonRepository: cartoonRepository);
      },
      wait: const Duration(milliseconds: 300),
      act: (bloc) => bloc.add(LoadMoreCartoons(mockFilter)),
      expect: () => [
        const AllCartoonsState.initial()
            .copyWith(status: CartoonStatus.loading),
        const AllCartoonsState.initial().copyWith(status: CartoonStatus.failure)
      ],
      verify: (_) => verify(() => cartoonRepository.loadMorePoliticalCartoons(
            sortByMode: mockFilter.sortByMode,
            imageType: mockFilter.imageType,
            tag: mockFilter.tag,
            limit: 15,
          )).called(1),
    );

    blocTest<AllCartoonsBloc, AllCartoonsState>(
      'bloc loads more cartoons and reaches max',
      build: () {
        when(() => cartoonRepository.loadMorePoliticalCartoons(
              sortByMode: mockFilter.sortByMode,
              imageType: mockFilter.imageType,
              tag: mockFilter.tag,
              limit: 15,
            )).thenAnswer((_) => Future.value([mockCartoon]));
        return AllCartoonsBloc(cartoonRepository: cartoonRepository);
      },
      wait: const Duration(milliseconds: 300),
      act: (bloc) => bloc.add(LoadMoreCartoons(mockFilter)),
      expect: () => [
        const AllCartoonsState.initial()
            .copyWith(status: CartoonStatus.loading),
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: [mockCartoon],
          hasReachedMax: true,
        )
      ],
      verify: (_) => verify(() => cartoonRepository.loadMorePoliticalCartoons(
            sortByMode: mockFilter.sortByMode,
            imageType: mockFilter.imageType,
            tag: mockFilter.tag,
            limit: 15,
          )).called(1),
    );

    blocTest<AllCartoonsBloc, AllCartoonsState>(
      'bloc loads more cartoons and doesn\'t reach the max',
      build: () {
        when(() => cartoonRepository.loadMorePoliticalCartoons(
              sortByMode: mockFilter.sortByMode,
              imageType: mockFilter.imageType,
              tag: mockFilter.tag,
              limit: 15,
            )).thenAnswer((_) => Future.value(List.filled(15, mockCartoon)));
        return AllCartoonsBloc(cartoonRepository: cartoonRepository);
      },
      wait: const Duration(milliseconds: 300),
      act: (bloc) => bloc.add(LoadMoreCartoons(mockFilter)),
      expect: () => [
        const AllCartoonsState.initial()
            .copyWith(status: CartoonStatus.loading),
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: List.filled(15, mockCartoon),
          hasReachedMax: false,
        )
      ],
      verify: (_) => verify(() => cartoonRepository.loadMorePoliticalCartoons(
            sortByMode: mockFilter.sortByMode,
            imageType: mockFilter.imageType,
            tag: mockFilter.tag,
            limit: 15,
          )).called(1),
    );
  });
}
