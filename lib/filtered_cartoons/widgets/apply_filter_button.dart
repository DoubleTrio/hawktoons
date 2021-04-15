import 'package:flutter/material.dart';

class ApplyFilterButton extends StatelessWidget {
  ApplyFilterButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 0.2, color: Colors.grey))),
      child: TextButton(
        child: const Text(
          'APPLY',
          style: TextStyle(fontSize: 18),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
