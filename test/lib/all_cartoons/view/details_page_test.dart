import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/widgets/cartoon_body/widgets.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('DetailsPage', () {
    late AllCartoonsPageCubit allCartoonsPageCubit;

    setUp(()  {
      allCartoonsPageCubit = MockAllCartoonsPageCubit();
    });

    setUpAll(() {
      registerFallbackValue<AllCartoonsPageState>(FakeAllCartoonsPageState());
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          DetailsView(cartoon: mockPoliticalCartoon),
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          DetailsView(cartoon: mockPoliticalCartoon),
          mode: ThemeMode.dark,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('cartoon body is present', (tester) async {
      await tester.pumpApp(
        DetailsView(cartoon: mockPoliticalCartoon),
      );
      expect(find.byType(CartoonBody), findsOneWidget);
    });

    testWidgets('deselects cartoon when back button '
      'is pressed', (tester) async {
      // when(() => allCartoonsPageCubit.state).thenReturn(
      //     const AllCartoonsPageState.initial()
      // );
      await tester.pumpApp(
        DetailsView(cartoon: mockPoliticalCartoon),
        allCartoonsPageCubit: allCartoonsPageCubit,
      );
      await tester.tap(find.byKey(detailsPageBackButtonKey));
      verify(allCartoonsPageCubit.deselectCartoon).called(1);
    });
  });
}
