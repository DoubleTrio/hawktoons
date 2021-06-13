import 'package:flutter/material.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppearancesCubit extends HydratedCubit<AppearancesState> {
  AppearancesCubit() : super(const AppearancesState.initial());

  void setTheme(ThemeMode theme) {
    return emit(state.copyWith(themeMode: theme));
  }

  void setColor(PrimaryColor color) {
    return emit(state.copyWith(primaryColor: color));
  }

  void setCartoonView(CartoonView view) {
    return emit(state.copyWith(cartoonView: view));
  }

  @override
  AppearancesState fromJson(Map<String, dynamic> json) {
    final themeMode = ThemeMode.values[json['themeMode'] as int];
    final primaryColor = PrimaryColor.values[json['primaryColor'] as int];
    final cartoonView = CartoonView.values[json['cartoonView'] as int];
    return AppearancesState(
      themeMode: themeMode,
      primaryColor: primaryColor,
      cartoonView: cartoonView
    );
  }

  @override
  Map<String, dynamic> toJson(AppearancesState state) {
    return <String, int>{
      'themeMode': state.themeMode.index,
      'primaryColor': state.primaryColor.index,
      'cartoonView': state.cartoonView.index,
    };
  }
}
