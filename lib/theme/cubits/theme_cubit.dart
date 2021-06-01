import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void setTheme(ThemeMode theme) {
    return emit(theme);
  }

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json['themeMode'] as int];
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return <String, int>{'themeMode': state.index};
  }
}
