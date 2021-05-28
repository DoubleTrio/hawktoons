import 'package:flutter/material.dart';


class AppDrawerPage extends StatelessWidget {
  const AppDrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
