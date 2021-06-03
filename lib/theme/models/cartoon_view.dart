import 'package:flutter/material.dart';
import 'package:hawktoons/l10n/l10n.dart';

enum CartoonView {
  staggered,
  card,
}

extension CartoonsViews on CartoonView {

  String? getViewType(AppLocalizations l10n) {
    final viewTypes = {
      CartoonView.staggered: l10n.staggered,
      CartoonView.card: l10n.card,
    };

    return viewTypes[this];
  }

  Icon? getIcon(Color color) {

    Icon _createIcon(IconData iconData) {
      return Icon(iconData, color: color)  ;
    }

    final viewTypes = {
      CartoonView.staggered: _createIcon(Icons.amp_stories),
      CartoonView.card: _createIcon(Icons.view_agenda_rounded),
    };

    return viewTypes[this];
  }
}