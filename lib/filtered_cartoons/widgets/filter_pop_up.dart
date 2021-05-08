import 'package:flutter/material.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class FilterPopUp extends StatefulWidget {
  @override
  _FilterPopUpState createState() => _FilterPopUpState();
}

class _FilterPopUpState extends State<FilterPopUp>
    with SingleTickerProviderStateMixin {
  final modes = SortByMode.values;
  final units = Unit.values.sublist(1);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.75,
        maxChildSize: 1,
        expand: false,
        builder: (context, scroller) {
          return SingleChildScrollView(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(1)),
              child: Column(
                children: <Widget>[
                  ButtonRowHeader(),
                  Divider(
                    height: 1.5,
                    color: theme.colorScheme.onBackground,
                  ),
                  const SizedBox(height: 12),
                  FilterHeader(header: 'Units'),
                  UnitButtonBar(units: units),
                  const SizedBox(height: 12),
                  FilterHeader(header: 'Sort By'),
                  SortByTileListView(modes: modes)
                ],
              ),
            ),
          );
        });
  }
}
