import 'package:flutter/material.dart';

class FilterIcon extends StatelessWidget {
  FilterIcon({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.filter_list), onPressed: onPressed);
  }
}
