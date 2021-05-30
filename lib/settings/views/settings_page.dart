import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/widgets/widgets.dart';

class SettingsPage extends Page<void> {
  const SettingsPage() : super(key: const ValueKey('SettingsPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
        const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void navigateToThemePage() {
      context.read<SettingsScreenCubit>().setScreen(SettingsScreen.theme);
    }

    return Scaffold(
      appBar: AppBar(title: const ScaffoldTitle(title: 'Settings')),
      body: Center(
        child: TextButton(
          key: const Key('SettingsView_NavigateToThemePage'),
          onPressed: navigateToThemePage,
          child: const Text('Navigate to theme page')
        )
      ),
    );
  }
}
