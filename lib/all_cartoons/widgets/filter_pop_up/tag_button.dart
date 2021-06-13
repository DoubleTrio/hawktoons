import 'package:flutter/material.dart';
import 'package:hawktoons/appearances/constants.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class TagButton extends StatelessWidget {
  const TagButton({
    Key? key,
    required this.tag,
    required this.onTap,
    required this.selected,
    }) : super(key: key);

  final Tag tag;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final onBackground = colorScheme.onBackground;
    final btnColor = selected ? primary : onBackground;

    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          ThemeConstants.defaultContainerPadding,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(btnColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: btnColor),
          )
        )
      ),
      child: Semantics(
        hint: 'Tap to select this tag to filter images',
        label: '${tag.name} tag',
        enabled: selected,
        selected: selected,
        button: true,
        child: Text(
          tag.name,
          style: TextStyle(fontSize: 14, color: btnColor),
        ),
      ),
    );
  }
}
