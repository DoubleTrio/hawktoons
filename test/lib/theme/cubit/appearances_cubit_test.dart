import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/appearances/appearances.dart';

import '../../helpers/helpers.dart';

void main() {
  setUp(initHydratedBloc);

  final initialState = const AppearancesState.initial();

  group('AppearancesCubit', () {
    test('initial state is AppearancesState.initial', () {
      expect(
        AppearancesCubit().state,
        initialState,
      );
    });

    test('toJson and fromJson works', () {
      final appearancesCubit = AppearancesCubit();
      final state = const AppearancesState.initial();
      expect(
        appearancesCubit.fromJson(appearancesCubit.toJson(state)),
        state,
      );
    });

    blocTest<AppearancesCubit, AppearancesState>(
      'emits correct theme state'
      'when setTheme is invoked',
      build: () => AppearancesCubit(),
      act: (cubit) =>
        cubit.setTheme(ThemeMode.dark),
      expect: () => [
        initialState.copyWith(themeMode: ThemeMode.dark),
      ],
    );

    blocTest<AppearancesCubit, AppearancesState>(
      'emits correct cartoonView state'
      'when setCartoonView is invoked',
      build: () => AppearancesCubit(),
      act: (cubit) =>
        cubit.setCartoonView(CartoonView.card),
      expect: () => [
        initialState.copyWith(cartoonView: CartoonView.card),
      ],
    );

    blocTest<AppearancesCubit, AppearancesState>(
      'emits correct primaryColor state'
      'when setPrimaryColor is invoked',
      build: () => AppearancesCubit(),
      act: (cubit) =>
          cubit.setColor(PrimaryColor.orange),
      expect: () => [
        initialState.copyWith(primaryColor: PrimaryColor.orange),
      ],
    );
  });
}