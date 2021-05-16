import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/widgets/filter_pop_up/tag_button.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class TagButtonBar extends StatelessWidget {
  const TagButtonBar({Key? key, required this.tags}): super(key: key);

  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    final selectedTag = context.watch<TagCubit>().state;

    final onTagButtonTap = (Tag tag) =>
      context.read<TagCubit>().selectTag(selectedTag == tag ? Tag.all : tag);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 5,
        children: [
          ...tags.map((tag) => TagButton(
            key: Key('Tag_Button_${tag.index}'),
            tag: tag,
            onTap: () => onTagButtonTap(tag),
            selected: selectedTag == tag)),
        ],
      ),
    );
  }
}
