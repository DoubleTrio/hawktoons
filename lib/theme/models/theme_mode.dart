import 'package:flutter/material.dart';
import 'package:hawktoons/l10n/l10n.dart';

extension ThemeModes on ThemeMode {
  String? getDescription(AppLocalizations l10n) {
    final descriptions = {
      ThemeMode.system: l10n.themePageSystemThemeText,
      ThemeMode.light: l10n.themePageLightThemeText,
      ThemeMode.dark: l10n.themePageDarkThemeText,
    };

    return descriptions[this];
  }
}