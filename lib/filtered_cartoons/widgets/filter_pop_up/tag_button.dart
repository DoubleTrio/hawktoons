import 'package:flutter/material.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class TagButton extends StatelessWidget {
  TagButton(
    {Key? key,
    required this.tag,
    required this.onTap,
    required this.selected,
    this.padding = 12}
  ) : super(key: key);

  final Tag tag;
  final VoidCallback? onTap;
  final bool selected;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final onBackground = colorScheme.onBackground;
    final btnColor = selected ? primary : onBackground;

    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding:
          MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(padding)),
        foregroundColor: MaterialStateProperty.all<Color>(btnColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: btnColor)
          )
        )
      ),
      child: Text(
        tag.name,
        style: TextStyle(fontSize: 12, color: btnColor),
      ),
    );
  }
}
