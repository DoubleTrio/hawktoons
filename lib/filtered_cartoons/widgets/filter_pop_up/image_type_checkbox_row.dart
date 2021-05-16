import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/widgets/filter_pop_up/filter_pop_up.dart';
import 'package:history_app/filtered_cartoons/widgets/filter_pop_up/image_type_checkbox.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class ImageTypeCheckboxRow extends StatelessWidget {
  const ImageTypeCheckboxRow({Key? key, required this.imageTypes })
    : super(key: key);

  final List<ImageType> imageTypes;

  @override
  Widget build(BuildContext context) {
    var selectedImageType = context.watch<ImageTypeCubit>().state;

    void _deselect() {
      context.read<ImageTypeCubit>().deselectImageType();
    }

    void _select(ImageType? type) {
      context.read<ImageTypeCubit>().selectImageType(type!);
    }

    return Container(
      width: double.infinity,
      height: Theme.of(context).textTheme.subtitle1!.fontSize!
          * 3 * (imageTypes.length / 2).ceil(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: StaggeredGridView.countBuilder(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 3.0,
        itemCount: imageTypes.length,
        itemBuilder: (context, index) {

          var type = imageTypes[index];
          return ImageTypeCheckbox(
            key: Key('ImageTypeCheckbox_${type.index}'),
            text: type.imageType,
            isSelected: selectedImageType == type,
            onSelect: () => _select(type),
            onDeselect: _deselect,
          );
        },
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      ),
    );
  }
}
