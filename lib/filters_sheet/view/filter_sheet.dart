import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/widgets/widgets.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class FilterSheet extends StatelessWidget {
  FilterSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final modes = SortByMode.values;
    final tags = Tag.values.sublist(1);
    final imageTypes = ImageType.values.sublist(1);
    final filters = context.watch<FilterSheetCubit>().state;

    void _filter() {
      Navigator.of(context).pop();
      context.read<AllCartoonsBloc>().add(LoadCartoons(filters));
    }

    void _reset() {
      context.read<FilterSheetCubit>().reset();
    }

    void _onSortByTileSelect(SortByMode mode) {
      return context.read<FilterSheetCubit>().selectSortBy(mode);
    }

    void _deselectImageType() {
      context.read<FilterSheetCubit>().deselectImageType();
    }

    void _selectImageType(ImageType? type) {
      context.read<FilterSheetCubit>().selectImageType(type!);
    }

    final _onTagChanged = (Tag tag) {
      context.read<FilterSheetCubit>().selectTag(
          filters.tag == tag ? Tag.all : tag
      );
    };

    return CustomDraggableSheet(
      child: Column(
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
                  FilterHeader(header: l10n.filterPopUpSortByHeader),
                  SortByTileListView(
                    modes: modes,
                    onTileTap: _onSortByTileSelect,
                  ),
                  const SizedBox(height: 24),
                  FilterHeader(header: l10n.filterPopUpImageTypeHeader),
                  ImageTypeCheckboxList(
                    imageTypes: imageTypes,
                    selectedImageType: filters.imageType,
                    onSelect: _selectImageType,
                    onDeselect: _deselectImageType,
                  ),
                  const SizedBox(height: 12),
                  FilterHeader(header: l10n.filterPopUpTagsHeader),
                  const SizedBox(height: 6),
                  TagButtonBar(
                    tags: tags,
                    selectedTag: filters.tag,
                    onTagChanged: _onTagChanged,
                  ),
                  const SizedBox(height: 12),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

