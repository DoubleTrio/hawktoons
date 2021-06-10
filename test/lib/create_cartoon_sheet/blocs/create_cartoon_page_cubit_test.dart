import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';

void main() {
  group('CreateCartoonPageCubit', () {
    test('initial state is VisibleOnboardingPage.welcome', () {
      expect(
        CreateCartoonPageCubit().state,
        equals(CreateCartoonPage.image),
      );
    });

    blocTest<CreateCartoonPageCubit, CreateCartoonPage>(
      'emits [VisibleOnboardingPage.latestCartoon] '
        'when selectSortBy is invoked',
      build: () => CreateCartoonPageCubit(),
      act: (cubit) =>
        cubit.setPage(CreateCartoonPage.description),
      expect: () => [CreateCartoonPage.description],
    );

    blocTest<CreateCartoonPageCubit, CreateCartoonPage>(
      'emits correct pages when setPage is invoked 3 times',
      build: () => CreateCartoonPageCubit(),
      act: (cubit) => cubit
        ..setPage(CreateCartoonPage.imageType)
        ..setPage(CreateCartoonPage.description)
        ..setPage(CreateCartoonPage.author),
      expect: () => [
        CreateCartoonPage.imageType,
        CreateCartoonPage.description,
        CreateCartoonPage.author,
      ],
    );
  });
}
