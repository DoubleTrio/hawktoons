import 'package:flutter/material.dart';

class CustomDraggableSheet extends StatelessWidget {
  const CustomDraggableSheet({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.75,
      maxChildSize: 1,
      expand: false,
      builder: (_, __) {
        return child;
      }
    );
  }
}
