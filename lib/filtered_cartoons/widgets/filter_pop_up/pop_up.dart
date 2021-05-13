import 'package:flutter/material.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/widgets/cartoon_scroll_bar.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class FilterPopUp extends StatelessWidget {
  final modes = SortByMode.values;
  final tags = Tag.values.sublist(1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.75,
      maxChildSize: 1,
      expand: false,
      builder: (context, scroller) {
        return Column(
          children: [
            ButtonRowHeader(),
            Divider(
              height: 1.5,
              color: theme.colorScheme.onBackground,
            ),
            Expanded(
              child: CartoonScrollBar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(children: [
                    const SizedBox(height: 12),
                    FilterHeader(header: 'Tags'),
                    TagButtonBar(tags: tags),
                    const SizedBox(height: 12),
                    FilterHeader(header: 'Sort By'),
                    SortByTileListView(modes: modes),
                    const SizedBox(height: 20),
                  ]),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
