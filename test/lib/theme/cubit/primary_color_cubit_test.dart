import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PrimaryColorCubit', () {
    setUpAll(initHydratedBloc);

    test('fromJson and toJson works', () {
      expect(
        PrimaryColorCubit().fromJson(
          PrimaryColorCubit().toJson(PrimaryColor.orange)
        ),
        PrimaryColor.orange
      );
    });

    blocTest<PrimaryColorCubit, PrimaryColor>(
      'emits correct colors when setColor is invoked',
      build: () => PrimaryColorCubit(),
      act: (cubit) => cubit
        ..setColor(PrimaryColor.red)
        ..setColor(PrimaryColor.orange),
      expect: () => [PrimaryColor.red, PrimaryColor.orange],
    );
  });
}
