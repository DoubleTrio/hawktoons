import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/widgets/filter_pop_up/filter_pop_up.dart';
import 'package:history_app/filtered_cartoons/widgets/filter_pop_up/image_type_checkbox.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:intl/intl.dart';

class ImageTypeCheckboxRow extends StatelessWidget {
  ImageTypeCheckboxRow({Key? key, required this.imageTypes }) : super(key: key);

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
    print(selectedImageType);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          ...imageTypes.map((type) => ImageTypeCheckbox(
            key: Key('ImageTypeCheckbox_${type.index}'),
            text: type.imageType,
            isSelected: selectedImageType == type,
            onSelect: () => _select(type),
            onDeselect: _deselect,
          ))
        ],
      ),
    );
  }
}
