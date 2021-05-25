import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/widgets/cartoon_body/widgets.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('DetailsPage', () {
    late SelectCartoonCubit selectCartoonCubit;

    setUp(() async {
      registerFallbackValue<SelectPoliticalCartoonState>(
        FakeSelectPoliticalCartoonState()
      );
      selectCartoonCubit = MockSelectCartoonCubit();

      when(() => selectCartoonCubit.state).thenReturn(
        SelectPoliticalCartoonState(cartoon: mockPoliticalCartoon)
      );
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          DetailsView(cartoon: mockPoliticalCartoon),
          selectCartoonCubit: selectCartoonCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          DetailsView(cartoon: mockPoliticalCartoon),
          mode: ThemeMode.dark,
          selectCartoonCubit: selectCartoonCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('cartoon body is present', (tester) async {
      await tester.pumpApp(
        DetailsView(cartoon: mockPoliticalCartoon),
        selectCartoonCubit: selectCartoonCubit,
      );
      expect(find.byType(CartoonBody), findsOneWidget);
    });

    testWidgets('deselects cartoon when back button '
      'is pressed', (tester) async {
      await tester.pumpApp(
        DetailsView(cartoon: mockPoliticalCartoon),
        selectCartoonCubit: selectCartoonCubit,
      );
      await tester.tap(find.byKey(detailsPageBackButtonKey));
      verify(selectCartoonCubit.deselectCartoon).called(1);
    });
  });
}
