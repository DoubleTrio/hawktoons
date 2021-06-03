import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';
import 'package:hawktoons/theme/cubits/cartoon_view_cubit.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../../mocks.dart';

void main() {
  final mockCartoons = [MockPoliticalCartoon()];

  group('AllCartoonsBloc', () {
    late FirestorePoliticalCartoonRepository cartoonRepository;
    late CartoonViewCubit cartoonViewCubit;

    setUpAll(() {
      registerFallbackValue<CartoonView>(CartoonView.staggered);
    });

    setUp(() {
      cartoonRepository = MockCartoonRepository();
      cartoonViewCubit = MockCartoonViewCubit();
    });

    test('initial state AllCartoonsState.initial', () {
      final state = const AllCartoonsState.initial();
      expect(
        AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        ).state,
        equals(state)
      );
    });

    blocTest<AllCartoonsBloc, AllCartoonsState>(
        'loads first set of images with a reached max status',
        build: () {
          when(() => cartoonRepository.politicalCartoons(
            sortByMode: mockFilter.sortByMode,
            imageType: mockFilter.imageType,
            tag: mockFilter.tag,
            limit: 15,
          )).thenAnswer((_) async => mockCartoons);
          return AllCartoonsBloc(
            cartoonRepository: cartoonRepository,
            cartoonViewCubit: cartoonViewCubit,
          );
        },
        // wait: ,
        act: (bloc) => bloc.add(LoadCartoons(mockFilter)),
        expect: () => [
          const AllCartoonsState.initial(),
          AllCartoonsState.loadSuccess(
            cartoons: mockCartoons,
            filters: mockFilter,
            hasReachedMax: true,
            view: CartoonView.staggered,
          )
        ],
        verify: (_) =>
          verify(() => cartoonRepository.politicalCartoons(
            sortByMode: mockFilter.sortByMode,
            imageType: mockFilter.imageType,
            tag: mockFilter.tag,
            limit: 15,
          )).called(1));

    blocTest<AllCartoonsBloc, AllCartoonsState>(
      'emits [] when first cartoons are already loaded '
      'and the same filters are applied',
      build: () {
        when(() => cartoonRepository.politicalCartoons(
          sortByMode: mockFilter.sortByMode,
          imageType: mockFilter.imageType,
          tag: mockFilter.tag,
          limit: 15,
        )).thenAnswer((_) async => mockCartoons);
        return AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        );
      },
      // wait: ,
      act: (bloc) => bloc.add(LoadCartoons(mockFilter)),
      seed: () => const AllCartoonsState.initial().copyWith(
        hasLoadedInitial: true
      ),
      expect: () => <AllCartoonsState>[],
      verify: (_) =>
        verifyNever(() => cartoonRepository.politicalCartoons(
          sortByMode: mockFilter.sortByMode,
          imageType: mockFilter.imageType,
          tag: mockFilter.tag,
          limit: 15,
      )));

    blocTest<AllCartoonsBloc, AllCartoonsState>(
      'loads first set of images with not a reached max status',
      build: () {
        when(() => cartoonRepository.politicalCartoons(
          sortByMode: mockFilter.sortByMode,
          imageType: mockFilter.imageType,
          tag: mockFilter.tag,
          limit: 15,
        )).thenAnswer((_) async => List.filled(15, mockCartoons[0]));
        return AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        );
      },
      // wait: ,
      act: (bloc) => bloc.add(LoadCartoons(mockFilter)),
      expect: () => <AllCartoonsState>[
        const AllCartoonsState.initial(),
        const AllCartoonsState.initial().copyWith(
          cartoons: List.filled(15, mockCartoons[0]),
          status: CartoonStatus.success,
          hasReachedMax: false,
          hasLoadedInitial: true,
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
        return AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        );
      },
      act: (bloc) => bloc.add(LoadCartoons(mockFilter)),
      expect: () => [
        AllCartoonsState.initial(filters: mockFilter),
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.failure,
          filters: mockFilter,
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
      'bloc loads more cartoons and errors',
      build: () {
        when(() => cartoonRepository.loadMorePoliticalCartoons(
          sortByMode: mockFilter.sortByMode,
          imageType: mockFilter.imageType,
          tag: mockFilter.tag,
          limit: 15,
        )).thenThrow(Exception('Error'));
        return AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        );
      },
      wait: const Duration(milliseconds: 300),
      act: (bloc) => bloc.add(const LoadMoreCartoons()),
      expect: () => [
        const AllCartoonsState.initial()
          .copyWith(status: CartoonStatus.loadingMore),
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
        )).thenAnswer((_) async => mockCartoons);
        return AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        );
      },
      wait: const Duration(milliseconds: 300),
      act: (bloc) => bloc.add(const LoadMoreCartoons()),
      expect: () => [
        const AllCartoonsState.initial()
          .copyWith(status: CartoonStatus.loadingMore),
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: mockCartoons,
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
        )).thenAnswer((_) async => List.filled(15, mockCartoons[0]));
        return AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        );
      },
      wait: const Duration(milliseconds: 300),
      act: (bloc) => bloc.add(const LoadMoreCartoons()),
      expect: () => [
        const AllCartoonsState.initial()
          .copyWith(status: CartoonStatus.loadingMore),
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: List.filled(15, mockCartoons[0]),
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


    blocTest<AllCartoonsBloc, AllCartoonsState>(
      'bloc refreshes cartoons and emits the correct states',
      build: () {
        when(() => cartoonRepository.politicalCartoons(
          sortByMode: mockFilter.sortByMode,
          imageType: mockFilter.imageType,
          tag: mockFilter.tag,
          limit: 15,
        )).thenAnswer((_) async => List.filled(15, mockCartoons[0]));
        return AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        );
      },
      wait: const Duration(milliseconds: 300),
      seed: () =>
        const AllCartoonsState.initial().copyWith(filters: mockFilter),
      act: (bloc) => bloc.add(const RefreshCartoons()),
      expect: () => [
        const AllCartoonsState.initial()
            .copyWith(status: CartoonStatus.refreshInitial),
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.refreshSuccess,
          cartoons: List.filled(15, mockCartoons[0]),
          hasLoadedInitial: true,
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
      'bloc refreshes cartoons, errors and emits correct states',
      build: () {
        when(() => cartoonRepository.politicalCartoons(
          sortByMode: mockFilter.sortByMode,
          imageType: mockFilter.imageType,
          tag: mockFilter.tag,
          limit: 15,
        )).thenThrow(Exception('Error'));
        return AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        );
      },
      wait: const Duration(milliseconds: 300),
      seed: () =>
        const AllCartoonsState.initial().copyWith(filters: mockFilter),
      act: (bloc) => bloc.add(const RefreshCartoons()),
      expect: () => [
        const AllCartoonsState.initial()
          .copyWith(status: CartoonStatus.refreshInitial),
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.refreshFailure,
        ),
      ],
      verify: (_) => verify(() => cartoonRepository.politicalCartoons(
        sortByMode: mockFilter.sortByMode,
        imageType: mockFilter.imageType,
        tag: mockFilter.tag,
        limit: 15,
      )).called(1),
    );

    blocTest<AllCartoonsBloc, AllCartoonsState>(
      'listens to cartoon view cubit and changes view key',
      build: () {
        whenListen(
          cartoonViewCubit,
          Stream<CartoonView>.value(CartoonView.card)
        );
        return AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        );
      },
      expect: () => [
        const AllCartoonsState.initial()
          .copyWith(view: CartoonView.card),
      ],
    );
  });
}
