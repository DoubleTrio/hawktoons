import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';

void main() {
  group('CreateCartoonSheetBloc', () {
    final initialState = CreateCartoonSheetState.initial();
    test('initial state is CartoonSheetState.initial', () {
      expect(
        CreateCartoonSheetBloc().state,
        initialState,
      );
    });

    blocTest<CreateCartoonSheetBloc, CreateCartoonSheetState>(
      'emits [] when UpdateFilter is added',
      build: () => CreateCartoonSheetBloc(),
      act: (bloc) => bloc.add(const UpdateFile()),
      expect: () => <CreateCartoonSheetState>[],
    );
  });
}
