import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/settings/settings.dart';

class SettingsFlowPage extends Page<void> {
  const SettingsFlowPage() : super(key: const ValueKey('SettingsFlowPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (_, __, ___) => const SettingsFlowView(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class SettingsFlowView extends StatelessWidget {
  const SettingsFlowView({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final _activeScreen = context.watch<SettingsScreenCubit>().state;

    return FlowBuilder<SettingsScreen>(
      state: _activeScreen,
      onGeneratePages: (SettingsScreen state, pages) {
        return [
          const SettingsPage(),
          if (_activeScreen == SettingsScreen.theme) const ThemePage(),
        ];
      }
    );
  }
}
