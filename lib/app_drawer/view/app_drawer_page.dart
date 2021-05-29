import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/auth/bloc/authentication_bloc.dart';
import 'package:hawktoons/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:hawktoons/theme/cubit/theme_cubit.dart';
import 'package:hawktoons/utils/constants.dart';
import 'package:hawktoons/widgets/cartoon_body/cartoon_section_divider.dart';

class AppDrawerPage extends StatelessWidget {
  const AppDrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/app/app_icon.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'example123@gmail.com',
                  style: TextStyle(fontSize: 20)
                ),
                const SizedBox(height: 16),
                const CartoonSectionDivider(),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        key: const Key('AppDrawerPage_Logout'),
                        leading: const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Icon(Icons.logout)
                        ),
                        onTap: _logout,
                        title: const Padding(
                          padding: EdgeInsets.only(left: 18),
                          child: Text('Logout'),
                        ),
                      ),
                      ListTile(
                        key: const Key('AppDrawerPage_Privacy'),
                        leading: const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Icon(Icons.security),
                        ),
                        onTap: () {},
                        title: const Padding(
                          padding: EdgeInsets.only(left: 18),
                          child: Text('Privacy Info'),
                        ),
                      ),
                      SwitchListTile(
                        key: const Key('AppDrawerPage_ChangeTheme'),
                        value: themeMode == ThemeMode.light,
                        onChanged: (val) {
                          _changeTheme();
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text('Dark Theme'),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
