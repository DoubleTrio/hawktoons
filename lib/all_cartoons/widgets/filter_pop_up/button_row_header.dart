import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/all_cartoons/blocs/blocs.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class ButtonRowHeader extends StatelessWidget {
  const ButtonRowHeader({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Filter applied!'),
        ),
      );
      context.read<AllCartoonsBloc>().add(LoadAllCartoons(
        filters
      ));
    }

    void _reset() {
      context.read<ImageTypeCubit>().deselectImageType();
      context.read<TagCubit>().selectTag(Tag.all);
      context.read<SortByCubit>().selectSortBy(SortByMode.latestPosted);
    }

    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final onSurface = colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            key: const Key('ButtonRowHeader_ResetButton'),
            onPressed: _reset,
            child: Text(
              'Reset',
              style: TextStyle(color: onSurface),
            )
          ),
          Row(
            children: [
              Text(
                'Filters',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: onSurface
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.filter_list, color: onSurface),
            ],
          ),
          TextButton(
            key: const Key('ButtonRowHeader_ApplyFilterButton'),
            onPressed: _filter,
            child: Text(
              'Apply',
              style: TextStyle(color: primary),
            ),
          ),
        ],
      ),
    );
  }
}
