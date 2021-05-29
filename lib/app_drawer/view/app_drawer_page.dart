import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/widgets/avatar_profile.dart';
import 'package:hawktoons/app_drawer/widgets/drawer_list_tile.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/auth/bloc/authentication_bloc.dart';
import 'package:hawktoons/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/theme/cubit/theme_cubit.dart';
import 'package:hawktoons/utils/constants.dart';

class AppDrawerPage extends StatelessWidget {
  const AppDrawerPage({
    Key? key,
    required this.backgroundOpacity,
  }) : super(key: key);

  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeMode = context.watch<ThemeCubit>().state;

    void _logout() {
      context.read<AllCartoonsBloc>().close();
      context.read<DailyCartoonBloc>().close();
      context.read<AuthenticationBloc>().add(const Logout());
    }

    void _changeTheme() {
      context.read<ThemeCubit>().changeTheme();
    }

    return Scaffold(
      body: Container(
        width: drawerSwipeDistance,
        color: Theme.of(context).colorScheme.surface,
        child: Stack(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const AvatarProfile(
                      email: 'example123@gmail.com',
                      avatarUrl: 'assets/images/app/app_icon.png',
                      name: 'Blyth Rayington',
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: [
                          DrawerListTile(
                            key: const Key('AppDrawerPage_Logout'),
                            onTap: _logout,
                            icon: const Icon(Icons.logout),
                            title: l10n.appDrawerLogoutButtonText,
                            label: l10n.appDrawerLogoutButtonLabel,
                            hint: l10n.appDrawerLogoutButtonHint,
                          ),
                          DrawerListTile(
                            key: const Key('AppDrawerPage_Privacy'),
                            onTap: () {},
                            icon: const Icon(Icons.security),
                            title: l10n.appDrawerPrivacyInfoButtonText,
                            label: l10n.appDrawerPrivacyInfoButtonLabel,
                            hint: l10n.appDrawerPrivacyInfoButtonHint,
                          ),
                          SwitchListTile(
                            key: const Key('AppDrawerPage_ChangeTheme'),
                            value: themeMode == ThemeMode.light,
                            onChanged: (val) {
                              _changeTheme();
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(themeMode == ThemeMode.light
                              ? l10n.appDrawerDarkThemeButtonText
                              : l10n.appDrawerLightThemeButtonText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: Container(
                color: Colors.black.withOpacity(backgroundOpacity),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
