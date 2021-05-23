import 'package:flutter/material.dart';

class ImageTypeCheckbox extends StatelessWidget {
  const ImageTypeCheckbox({
    Key? key,
    required this.keyString,
    required this.text,
    required this.isSelected,
    required this.onSelect,
    required this.onDeselect,
  }) : super(key: key);

  final String keyString;
  final String text;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onDeselect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      child: Row(
        children: [
          Material(
            child: Semantics(
              hint: 'Tap to filter political image by text',
              label: '$text image type',
              enabled: isSelected,
              selected: isSelected,
              child: Checkbox(
                key: Key('${keyString}_Checkbox'),
                activeColor: theme.colorScheme.primary,
                value: isSelected,
                onChanged: (selected) => selected! ? onSelect() : onDeselect()
              ),
            ),
          ),
          Text(text, style: theme.textTheme.subtitle1),
        ],
      ),
    );
  }
}
