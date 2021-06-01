import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('CartoonViewCubit', () {
    setUpAll(initHydratedBloc);

    test('fromJson and toJson works', () {
      expect(
        CartoonViewCubit().fromJson(
          CartoonViewCubit().toJson(CartoonView.card)
        ),
        CartoonView.card,
      );
    });

    blocTest<CartoonViewCubit, CartoonView>(
      'emits correct views when setCartoonView is invoked',
      build: () => CartoonViewCubit(),
      act: (cubit) => cubit
        ..setCartoonView(CartoonView.card)
        ..setCartoonView(CartoonView.compact),
      expect: () => [CartoonView.card, CartoonView.compact],
    );
  });
}
