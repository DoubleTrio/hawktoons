import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hawktoons/all_cartoons/widgets/widgets.dart';
import 'package:hawktoons/theme/constants.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class ImageTypeCheckboxList extends StatelessWidget {
  const ImageTypeCheckboxList({
    Key? key,
    required this.imageTypes,
    required this.selectedImageType,
    required this.onDeselect,
    required this.onSelect,
  })
    : super(key: key);

  final List<ImageType> imageTypes;
  final ImageType selectedImageType;
  final VoidCallback onDeselect;
  final ValueChanged<ImageType> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: ThemeConstants.mPadding),
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
            isSelected: selectedImageType == type,
            onSelect: () => onSelect(type),
            onDeselect: onDeselect,
          );
        },
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      ),
    );
  }
}
