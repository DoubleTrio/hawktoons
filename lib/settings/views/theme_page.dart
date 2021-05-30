import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/settings/cubit/settings_screen_cubit.dart';
import 'package:hawktoons/theme/cubit/theme_cubit.dart';
import 'package:hawktoons/widgets/widgets.dart';

class ThemePage extends Page<void> {
  const ThemePage() : super(key: const ValueKey('ThemePage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
        const ThemeView(),
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = const Offset(1.0, 0.0);
        final end = Offset.zero;
        final curve = Curves.easeInCubic;
        final tween = Tween(begin: begin, end: end)
          ..chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class ThemeView extends StatelessWidget {
  const ThemeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _navigateBack() {
      context.read<SettingsScreenCubit>().deselectScreen();
    }

    void _changeTheme() {
      context.read<ThemeCubit>().changeTheme();
    }

    return Scaffold(
      appBar: AppBar(
        title: const ScaffoldTitle(title: 'Theme'),
        centerTitle: true,
        leading: CustomIconButton(
          onPressed: _navigateBack,
          icon: const Icon(Icons.arrow_back),
          label: 'Back button',
          hint: 'Tap to navigate back to the main settings page',
        ),
      ),
      body: Center(
        child: TextButton(
          key: const Key('ThemePage_ChangeThemeButton'),
          onPressed: _changeTheme,
          child: const Text('Tap to change the theme')
        )
      ),
    );
  }
}
