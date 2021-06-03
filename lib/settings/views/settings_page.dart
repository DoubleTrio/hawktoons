import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/l10n/l10n.dart';
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
    final theme = Theme.of(context);
    final l10n = context.l10n;

    void _navigateToThemePage() {
      context.read<SettingsScreenCubit>().setScreen(SettingsScreen.theme);
    }

    return Scaffold(
      appBar: AppBar(
        title: ScaffoldTitle(title: l10n.settingsPageSettingsText),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          TappableTile(
            key: const Key('SettingsView_NavigateToThemePage'),
            onTap: _navigateToThemePage,
            leading: Icon(
              Icons.wb_sunny_outlined,
              color: theme.colorScheme.onBackground,
            ),
            isLast: true,
            navigable: true,
            child: Text(
              l10n.appearancePageAppearanceText,
              style: theme.textTheme.subtitle1
            ),
          )
        ],
      )
    );
  }
}
