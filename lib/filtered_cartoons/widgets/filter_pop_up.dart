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
    return DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.75,
        maxChildSize: 1,
        expand: false,
        builder: (context, scroller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Column(
                  children: <Widget>[
                    ButtonRowHeader(),
                    const Divider(
                      height: 1,
                      color: Colors.black45,
                    ),
                    const SizedBox(height: 12),
                    FilterHeader(header: 'Units'),
                    UnitButtonBar(units: units),
                    const SizedBox(height: 12),
                    FilterHeader(header: 'Sort By'),
                    const SizedBox(height: 12),
                    SortByTileListView(modes: modes)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
