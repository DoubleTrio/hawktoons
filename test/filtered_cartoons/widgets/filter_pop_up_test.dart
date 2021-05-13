import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

const _resetFilterButtonKey = Key('ButtonRowHeader_ResetButton');
const _applyFilterButtonKey = Key('ButtonRowHeader_ApplyFilterButton');

final sortByMode = SortByMode.latestPosted;
final tag = Tag.tag5;

final _tagButtonKey = Key('Tag_Button_${tag.index}');
final _sortByTileKey = Key('SortByMode_Button_${sortByMode.index}');


void main() {
  group('FilterPopUp', () {
    late AllCartoonsBloc allCartoonsBloc;
    late TagCubit tagCubit;
    late SortByCubit sortByCubit;
    late FilteredCartoonsBloc filteredCartoonsBloc;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: tagCubit),
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: sortByCubit),
        BlocProvider.value(value: filteredCartoonsBloc),
      ], child: child);
    }
    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<FilteredCartoonsState>(FakeFilteredCartoonsState());
      registerFallbackValue<FilteredCartoonsEvent>(FakeFilteredCartoonsEvent());
      registerFallbackValue<TabEvent>(FakeTabEvent());
      registerFallbackValue<Tag>(Tag.all);
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);

      allCartoonsBloc = MockAllCartoonsBloc();
      tagCubit = MockTagCubit();
      sortByCubit = MockSortByCubit();
      filteredCartoonsBloc = MockFilteredCartoonsBloc();

      when(() => allCartoonsBloc.state).thenReturn(AllCartoonsLoading());
      when(() => filteredCartoonsBloc.state)
        .thenReturn(FilteredCartoonsLoading());
      when(() => tagCubit.state).thenReturn(Tag.all);
      when(() => sortByCubit.state).thenReturn(SortByMode.earliestPosted);
    });

    group('FilterPopUp', () {

      testWidgets('selects sorting mode', (tester) async {
        await tester.pumpApp(wrapper(FilterPopUp()));

        await tester.tap(find.byKey(_sortByTileKey));
        await tester.pumpAndSettle();
        verify(() => sortByCubit.selectSortBy(sortByMode)).called(1);
      });

      testWidgets('selects filter tag', (tester) async {
        await tester.pumpApp(wrapper(FilterPopUp()));

        await tester.tap(find.byKey(_tagButtonKey));
        await tester.pumpAndSettle();
        verify(() => tagCubit.selectTag(tag)).called(1);
      });

      testWidgets('deselects filter tag', (tester) async {
        when(() => tagCubit.state).thenReturn(Tag.tag5);

        await tester.pumpApp(wrapper(FilterPopUp()));

        await tester.tap(find.byKey(_tagButtonKey));
        await tester.pumpAndSettle();
        verify(() => tagCubit.selectTag(Tag.all)).called(1);
      });

      testWidgets('reset button works', (tester) async {
        when(() => tagCubit.state).thenReturn(Tag.tag5);
        when(() => sortByCubit.state).thenReturn(SortByMode.earliestPublished);

        await tester.pumpApp(wrapper(FilterPopUp()));

        await tester.tap(find.byKey(_resetFilterButtonKey));
        await tester.pumpAndSettle();

        verify(() => tagCubit.selectTag(Tag.all)).called(1);
        verify(() => sortByCubit.selectSortBy(SortByMode.latestPosted))
          .called(1);
      });

      testWidgets('applies correct filter', (tester) async {
        when(() => tagCubit.state).thenReturn(tag);
        when(() => sortByCubit.state).thenReturn(sortByMode);

        await tester.pumpApp(wrapper(FilterPopUp()));

        await tester.tap(find.byKey(_applyFilterButtonKey));
        await tester.pumpAndSettle();

        verify(() => allCartoonsBloc.add(
          LoadAllCartoons(sortByMode)
        )).called(1);

        verify(() => filteredCartoonsBloc.add(UpdateFilter(tag)))
          .called(1);
      });
    });
  });
}
