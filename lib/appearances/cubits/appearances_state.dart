import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hawktoons/appearances/appearances.dart';

class AppearancesState extends Equatable {
  const AppearancesState({
    required this.themeMode,
    required this.primaryColor,
    required this.cartoonView,
  });

  const AppearancesState.initial() : this(
    themeMode: ThemeMode.system,
    primaryColor: PrimaryColor.purple,
    cartoonView: CartoonView.staggered,
  );

  final ThemeMode themeMode;
  final PrimaryColor primaryColor;
  final CartoonView cartoonView;

  AppearancesState copyWith({
    ThemeMode? themeMode,
    PrimaryColor? primaryColor,
    CartoonView? cartoonView,
  }) {
    return AppearancesState(
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
      cartoonView: cartoonView ?? this.cartoonView,
    );
  }

  @override
  List<Object?> get props =>
    [
      themeMode,
      primaryColor,
      cartoonView
    ];
}
