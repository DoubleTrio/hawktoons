import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/widgets/app_scroll_bar.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class FilterPopUp extends StatelessWidget {
  FilterPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final modes = SortByMode.values;
    final tags = Tag.values.sublist(1);
    final imageTypes = ImageType.values.sublist(1);

    final _selectedImageType = context.watch<ImageTypeCubit>().state;
    final _selectedTag = context.watch<TagCubit>().state;
    final _sortByMode = context.watch<SortByCubit>().state;
    final _imageType = context.watch<ImageTypeCubit>().state;

    final filters = CartoonFilters(
      sortByMode: _sortByMode,
      imageType: _imageType,
      tag: _selectedTag
    );

    void _filter() {
      Navigator.of(context).pop();
      context.read<AllCartoonsBloc>().add(LoadCartoons(filters));
    }

    void _reset() {
      context.read<ImageTypeCubit>().deselectImageType();
      context.read<TagCubit>().selectTag(Tag.all);
      context.read<SortByCubit>().selectSortBy(SortByMode.latestPosted);
    }

    void _onSortByTileSelect(SortByMode mode) {
      return context.read<SortByCubit>().selectSortBy(mode);
    }

    void _deselectImageType() {
      context.read<ImageTypeCubit>().deselectImageType();
    }

    void _selectImageType(ImageType? type) {
      context.read<ImageTypeCubit>().selectImageType(type!);
    }

    final _onTagChanged = (Tag tag) =>
      context.read<TagCubit>().selectTag(_selectedTag == tag ? Tag.all : tag);

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.75,
      maxChildSize: 1,
      expand: false,
      builder: (context, scroller) {
        return Column(
          children: [
            ButtonRowHeader(onReset: _reset, onFilter: _filter),
            Divider(
              height: 1.5,
              color: theme.colorScheme.onBackground,
            ),
            Expanded(
              child: AppScrollBar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(children: [
                    const SizedBox(height: 12),
                    const FilterHeader(header: 'Sort By'),
                    SortByTileListView(
                        modes: modes,
                        onTileTap: _onSortByTileSelect
                    ),
                    const SizedBox(height: 24),
                    const FilterHeader(header: 'Image Type'),
                    ImageTypeCheckboxList(
                      imageTypes: imageTypes,
                      selectedImageType: _selectedImageType,
                      onSelect: _selectImageType,
                      onDeselect: _deselectImageType,
                    ),
                    const SizedBox(height: 12),
                    const FilterHeader(header: 'Tags'),
                    const SizedBox(height: 6),
                    TagButtonBar(
                      tags: tags,
                      selectedTag: _selectedTag,
                      onTagChanged: _onTagChanged,
                    ),
                    const SizedBox(height: 12),
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
