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
          unit: Unit.unit1,
          downloadUrl: 'downloadurl')
    ];

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(AllCartoonsLoading());
      registerFallbackValue<AllCartoonsEvent>(LoadAllCartoons());
      registerFallbackValue<FilteredCartoonsEvent>(UpdateFilter(Unit.unit1));
      registerFallbackValue<FilteredCartoonsState>(FilteredCartoonsLoading());
      allCartoonsBloc = MockAllCartoonsBloc();
    });

    test('initial state is FilteredCartoonsLoading()', () {
      when(() => allCartoonsBloc.state).thenReturn(AllCartoonsLoading());
      var state = FilteredCartoonsLoading();
      expect(FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc).state,
          equals(state));
    });

    test('initial state is FilteredCartoonsLoaded()', () {
      when(() => allCartoonsBloc.state)
          .thenReturn(AllCartoonsLoaded(cartoons: politicalCartoons));
      expect(FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc).state,
          equals(FilteredCartoonsLoaded(politicalCartoons, Unit.all)));
    });

    test('initial state is FilteredCartoonsFailed()', () {
      when(() => allCartoonsBloc.state).thenReturn(AllCartoonsFailed('Error'));
      expect(FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc).state,
          equals(FilteredCartoonsFailed('Error')));
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
      expect: () => [FilteredCartoonsLoaded(politicalCartoons, Unit.all)],
      verify: (_) {},
    );

    blocTest<FilteredCartoonsBloc, FilteredCartoonsState>(
      'emits [FilteredCartoonsLoaded($tempCartoons, Unit.unit1), '
      'FilteredCartoonsLoaded($tempCartoons, Unit.all), '
      'FilteredCartoonsLoaded($tempCartoons, Unit.unit3)] '
      'when UpdateFilter is added',
      build: () {
        when(() => allCartoonsBloc.stream).thenAnswer(
            (_) => Stream.value(AllCartoonsLoaded(cartoons: tempCartoons)));
        when(() => allCartoonsBloc.state)
            .thenAnswer((_) => AllCartoonsLoaded(cartoons: tempCartoons));
        return FilteredCartoonsBloc(allCartoonsBloc: allCartoonsBloc);
      },
      act: (bloc) => bloc
        ..add(UpdateFilter(Unit.all))
        ..add(UpdateFilter(Unit.unit3))
        ..add(UpdateFilter(Unit.unit1)),
      expect: () => [
        FilteredCartoonsLoaded(tempCartoons, Unit.all),
        FilteredCartoonsLoaded([], Unit.unit3),
        FilteredCartoonsLoaded(tempCartoons, Unit.unit1),
      ],
    );
  });
}
