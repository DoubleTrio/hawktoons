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
    final defaultAllCartoonsState = const AllCartoonsState.initial(
      view: CartoonView.staggered,
    );
    late FirestorePoliticalCartoonRepository cartoonRepository;
    late CartoonViewCubit cartoonViewCubit;

    setUpAll(() {
      registerFallbackValue<CartoonView>(CartoonView.staggered);
    });

    setUp(() {
      cartoonRepository = MockCartoonRepository();
      cartoonViewCubit = MockCartoonViewCubit();
      when(() => cartoonViewCubit.state).thenReturn(CartoonView.staggered);
    });

    test('initial state AllCartoonsState.initial', () {
      expect(
        AllCartoonsBloc(
          cartoonRepository: cartoonRepository,
          cartoonViewCubit: cartoonViewCubit,
        ).state,
        equals(defaultAllCartoonsState)
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
          defaultAllCartoonsState,
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
      seed: () => defaultAllCartoonsState.copyWith(
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
        defaultAllCartoonsState,
        defaultAllCartoonsState.copyWith(
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
        defaultAllCartoonsState.copyWith(filters: mockFilter),
        defaultAllCartoonsState.copyWith(
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
        defaultAllCartoonsState.copyWith(status: CartoonStatus.loadingMore),
        defaultAllCartoonsState.copyWith(status: CartoonStatus.failure)
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
        defaultAllCartoonsState
          .copyWith(status: CartoonStatus.loadingMore),
        defaultAllCartoonsState.copyWith(
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
        defaultAllCartoonsState
          .copyWith(status: CartoonStatus.loadingMore),
        defaultAllCartoonsState.copyWith(
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
      seed: () => defaultAllCartoonsState.copyWith(filters: mockFilter),
      act: (bloc) => bloc.add(const RefreshCartoons()),
      expect: () => [
        defaultAllCartoonsState
          .copyWith(status: CartoonStatus.refreshInitial),
        defaultAllCartoonsState.copyWith(
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
          defaultAllCartoonsState.copyWith(filters: mockFilter),
      act: (bloc) => bloc.add(const RefreshCartoons()),
      expect: () => [
        defaultAllCartoonsState
          .copyWith(status: CartoonStatus.refreshInitial),
        defaultAllCartoonsState.copyWith(
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
        defaultAllCartoonsState
          .copyWith(view: CartoonView.card),
      ],
    );
  });
}
