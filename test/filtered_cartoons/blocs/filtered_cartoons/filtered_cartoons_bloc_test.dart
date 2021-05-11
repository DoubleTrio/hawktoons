import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockAllCartoonsBloc extends MockBloc<AllCartoonsEvent, AllCartoonsState>
    implements AllCartoonsBloc {}

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('FilteredCartoonsBloc', () {
    late MockAllCartoonsBloc allCartoonsBloc;

    var politicalCartoons = [MockPoliticalCartoon()];
    var tempCartoons = [
      PoliticalCartoon(
          id: '2',
          author: 'Bob',
          date: Timestamp.now(),
          published: Timestamp.now(),
          description: 'Another Mock Political Cartoon',
          tags: [Tag.tag1],
          downloadUrl: 'downloadurl')
    ];

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(AllCartoonsLoading());
      registerFallbackValue<AllCartoonsEvent>(
          LoadAllCartoons(SortByMode.latestPosted));
      registerFallbackValue<FilteredCartoonsEvent>(UpdateFilter(Tag.tag1));
      registerFallbackValue<FilteredCartoonsState>(FilteredCartoonsLoading());
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
            equals(FilteredCartoonsLoaded(politicalCartoons, Tag.all)));
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
            Stream.value(AllCartoonsLoaded(cartoons: politicalCartoons)));
        when(() => allCartoonsBloc.state)
            .thenAnswer((_) => AllCartoonsLoaded(cartoons: politicalCartoons));
        return FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc);
      },
      act: (bloc) {},
      expect: () => [FilteredCartoonsLoaded(politicalCartoons, Tag.all)],
      verify: (_) {},
    );

    blocTest<FilteredCartoonsBloc, FilteredCartoonsState>(
      'emits [FilteredCartoonsLoaded($tempCartoons, Tag.tag1), '
      'FilteredCartoonsLoaded($tempCartoons, Tag.all), '
      'FilteredCartoonsLoaded($tempCartoons, Tag.tag3)] '
      'when UpdateFilter is added',
      build: () {
        when(() => allCartoonsBloc.stream).thenAnswer(
            (_) => Stream.value(AllCartoonsLoaded(cartoons: tempCartoons)));
        when(() => allCartoonsBloc.state)
            .thenAnswer((_) => AllCartoonsLoaded(cartoons: tempCartoons));
        return FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc);
      },
      act: (bloc) => bloc
        ..add(UpdateFilter(Tag.all))
        ..add(UpdateFilter(Tag.tag3))
        ..add(UpdateFilter(Tag.tag1)),
      expect: () => [
        FilteredCartoonsLoaded(tempCartoons, Tag.all),
        FilteredCartoonsLoaded([], Tag.tag3),
        FilteredCartoonsLoaded(tempCartoons, Tag.tag1),
      ],
    );
  });
}
