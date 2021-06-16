import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/create_cartoon_sheet/bloc/bloc.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('CreateCartoonSheet', () {
    final initialState = CreateCartoonSheetState.initial();

    late CreateCartoonSheetBloc createCartoonSheetBloc;

    setUpAll(() {
      registerFallbackValue<CreateCartoonSheetState>(
        FakeCreateCartoonSheetState()
      );
      registerFallbackValue<CreateCartoonSheetEvent>(
        FakeCreateCartoonSheetEvent()
      );
    });

    setUp(() {
      createCartoonSheetBloc = MockCreateCartoonSheetBloc();
      when(() => createCartoonSheetBloc.state).thenReturn(initialState);
    });

    // TODO - adjust ui to fix android text guidelines
    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const CreateCartoonPopUp(),
          createCartoonSheetBloc: createCartoonSheetBloc,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const CreateCartoonPopUp(),
          mode: ThemeMode.dark,
          createCartoonSheetBloc: createCartoonSheetBloc,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('can upload image', (tester) async {
      await tester.pumpApp(
        const CreateCartoonPopUp(),
        mode: ThemeMode.dark,
        createCartoonSheetBloc: createCartoonSheetBloc,
      );

      await tester.tap(find.byKey(
        const Key('CreateCartoonSheet_UploadImageButton')
      ));
      verify(() => createCartoonSheetBloc.add(const UploadImage())).called(1);
    });

    testWidgets('displays image file after image is selected', (tester) async {
      when(() => createCartoonSheetBloc.state).thenReturn(
        CreateCartoonSheetState.initial().copyWith(
          details: const CreateCartoonDetails(filePath: '12345')
        )
      );
      await tester.pumpApp(
        const CreateCartoonPopUp(),
        mode: ThemeMode.dark,
        createCartoonSheetBloc: createCartoonSheetBloc,
      );
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
