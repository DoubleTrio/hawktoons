import 'package:flutter/material.dart';
import 'package:hawktoons/appearances/constants.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class TagButtonBar extends StatelessWidget {
  const TagButtonBar({
    Key? key,
    required this.tags,
    required this.selectedTag,
    required this.onTagChanged,
  }) : super(key: key);

  final List<Tag> tags;
  final ValueChanged<Tag> onTagChanged;
  final Tag selectedTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemeConstants.mPadding),
      child: Wrap(
        spacing: 5,
        children: [
          ...tags.map((tag) => TagButton(
            key: Key('Tag_Button_${tag.index}'),
            tag: tag,
            onTap: () => onTagChanged(tag),
            selected: selectedTag == tag,
          )),
        ],
      ),
    );
  }
}
