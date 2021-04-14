import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/theme/theme.dart';

class ThemeFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: const Key('ThemeFloatingActionButton_ChangeTheme'),
      child: const Icon(Icons.lightbulb_outline),
      onPressed: () => context.read<ThemeCubit>().changeTheme(),
    );
  }
}
