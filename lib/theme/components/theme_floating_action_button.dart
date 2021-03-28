import 'package:flutter/material.dart';
import 'package:history_app/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: const Key('changeTheme_themeFloatingActionButton'),
      child: const Icon(Icons.lightbulb_outline),
      onPressed: () => context.read<ThemeCubit>().changeTheme(),
    );
  }
}
