import 'package:flutter/material.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/widgets/cartoon_scroll_bar.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class FilterPopUp extends StatelessWidget {
  FilterPopUp({Key? key}) : super(key: key);

  final modes = SortByMode.values;
  final tags = Tag.values.sublist(1);
  final imageTypes = ImageType.values.sublist(1);

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
            const ButtonRowHeader(),
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
                    const FilterHeader(header: 'Tags'),
                    const SizedBox(height: 6),
                    TagButtonBar(tags: tags),
                    const SizedBox(height: 12),
                    const FilterHeader(header: 'Image Type'),
                    ImageTypeCheckboxRow(imageTypes: imageTypes),
                    const SizedBox(height: 12),
                    const FilterHeader(header: 'Sort By'),
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
