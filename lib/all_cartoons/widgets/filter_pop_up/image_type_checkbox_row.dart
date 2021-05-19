import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:history_app/all_cartoons/blocs/blocs.dart';
import 'package:history_app/all_cartoons/widgets/widgets.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class ImageTypeCheckboxRow extends StatelessWidget {
  const ImageTypeCheckboxRow({Key? key, required this.imageTypes})
    : super(key: key);

  final List<ImageType> imageTypes;

  @override
  Widget build(BuildContext context) {
    final _selectedImageType = context.watch<ImageTypeCubit>().state;

    void _deselect() {
      context.read<ImageTypeCubit>().deselectImageType();
    }

    void _select(ImageType? type) {
      context.read<ImageTypeCubit>().selectImageType(type!);
    }
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: StaggeredGridView.countBuilder(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 3.0,
        itemCount: imageTypes.length,
        itemBuilder: (context, index) {
          final type = imageTypes[index];
          return ImageTypeCheckbox(
            key: Key('ImageTypeCheckbox_${type.index}'),
            keyString: 'ImageTypeCheckbox_${type.index}',
            text: type.imageType,
            isSelected: _selectedImageType == type,
            onSelect: () => _select(type),
            onDeselect: _deselect,
          );
        },
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      ),
    );
  }
}
