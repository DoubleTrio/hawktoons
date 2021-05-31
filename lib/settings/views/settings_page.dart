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

    void _navigateToThemePage() {
      context.read<SettingsScreenCubit>().setScreen(SettingsScreen.theme);
    }

    return Scaffold(
      appBar: AppBar(
        title: const ScaffoldTitle(title: 'Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            key: const Key('SettingsView_NavigateToThemePage'),
            onTap: _navigateToThemePage,
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Appearance'),
          )
        ],
      )
    );
  }
}
