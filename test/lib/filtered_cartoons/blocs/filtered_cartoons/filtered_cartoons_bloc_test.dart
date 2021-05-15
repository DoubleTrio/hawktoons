import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../../fakes.dart';
import '../../../mocks.dart';

void main() {
  group('FilteredCartoonsBloc', () {
    late MockAllCartoonsBloc allCartoonsBloc;

    var politicalCartoons = [MockPoliticalCartoon()];

    var mockCartoons = [mockPoliticalCartoon];

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<FilteredCartoonsEvent>(FakeFilteredCartoonsEvent());
      registerFallbackValue<FilteredCartoonsState>(FakeFilteredCartoonsState());
      allCartoonsBloc = MockAllCartoonsBloc();
    });
    
    group('initials states', () {
      test('initial state is FilteredCartoonsFailed()', () {
        when(() => allCartoonsBloc.state)
          .thenReturn(AllCartoonsFailed('Error'));
        var bloc = FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc);
        expect(bloc.state, equals(FilteredCartoonsFailed('Error')));
      });

      test('initial state is FilteredCartoonsLoaded()', () {
        when(() => allCartoonsBloc.state)
          .thenReturn(AllCartoonsLoaded(cartoons: politicalCartoons));
        var bloc = FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc);
        expect(bloc.state,
          equals(
            FilteredCartoonsLoaded(politicalCartoons, Tag.all, ImageType.all)
          ));
      });

      test('initial state is FilteredCartoonsLoading()', () {
        when(() => allCartoonsBloc.state).thenReturn(AllCartoonsLoading());
        var state = FilteredCartoonsLoading();
        expect(FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc).state,
            equals(state));
      });
    });
    blocTest<FilteredCartoonsBloc, FilteredCartoonsState>(
      'Emits [AllCartoonsLoaded(cartoons: $politicalCartoons)] '
      'when LoadAllCartoons is added',
      build: () {
        when(() => allCartoonsBloc.stream).thenAnswer((_) =>
          Stream.value(AllCartoonsLoaded(cartoons: politicalCartoons))
        );
        when(() => allCartoonsBloc.state)
          .thenAnswer((_) => AllCartoonsLoaded(cartoons: politicalCartoons));
        return FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc);
      },
      act: (bloc) {},
      expect: () => [
        FilteredCartoonsLoaded(politicalCartoons, Tag.all, ImageType.all)
      ],
    );

    blocTest<FilteredCartoonsBloc, FilteredCartoonsState>(
      'applies tag filter correctly',
      build: () {
        whenListen(allCartoonsBloc,
          Stream.value(AllCartoonsLoaded(cartoons: mockCartoons))
        );
        when(() => allCartoonsBloc.state)
          .thenAnswer((_) => AllCartoonsLoaded(cartoons: mockCartoons));
        return FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc);
      },
      act: (bloc) => bloc
        ..add(UpdateFilter(Tag.all, ImageType.all))
        ..add(UpdateFilter(Tag.tag3, ImageType.all))
        ..add(UpdateFilter(Tag.tag1, ImageType.all)),
      expect: () => [
        FilteredCartoonsLoaded(mockCartoons, Tag.all, ImageType.all),
        FilteredCartoonsLoaded([], Tag.tag3, ImageType.all),
        FilteredCartoonsLoaded(mockCartoons, Tag.tag1, ImageType.all),
      ],
    );

    blocTest<FilteredCartoonsBloc, FilteredCartoonsState>(
      'applies image type filter correctly',
      build: () {
        whenListen(allCartoonsBloc,
          Stream.value(AllCartoonsLoaded(cartoons: mockCartoons))
        );

        when(() => allCartoonsBloc.state)
          .thenAnswer((_) => AllCartoonsLoaded(cartoons: mockCartoons));

        return FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc);
      },
      act: (bloc) => bloc
        ..add(UpdateFilter(Tag.all, ImageType.all))
        ..add(UpdateFilter(Tag.all, ImageType.document))
        ..add(UpdateFilter(Tag.all, ImageType.cartoon)),
      expect: () => [
        FilteredCartoonsLoaded(mockCartoons, Tag.all, ImageType.all),
        FilteredCartoonsLoaded([], Tag.all, ImageType.document),
        FilteredCartoonsLoaded(mockCartoons, Tag.all, ImageType.cartoon),
      ],
    );
  });
}
