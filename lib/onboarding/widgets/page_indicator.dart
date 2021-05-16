import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key? key, required this.isActive}): super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? colorScheme.primary : colorScheme.onBackground,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
