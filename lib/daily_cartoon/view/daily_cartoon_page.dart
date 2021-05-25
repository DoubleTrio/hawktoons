import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/all_cartoons/blocs/all_cartoons_bloc/all_cartoons_bloc.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon_bloc.dart';
import 'package:history_app/widgets/cartoon_body.dart';
import 'package:history_app/widgets/custom_icon_button.dart';
import 'package:history_app/widgets/page_header.dart';
import 'package:history_app/widgets/scaffold_title.dart';
import 'package:history_app/widgets/widgets.dart';
import 'package:intl/intl.dart';

class DailyCartoonPage extends Page<void> {
  const DailyCartoonPage() : super(key: const ValueKey('DailyCartoonPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (_, __, ___) => const DailyCartoonView(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class DailyCartoonView extends StatelessWidget {
  const DailyCartoonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _logout() {
      context.read<AllCartoonsBloc>().close();
      context.read<DailyCartoonBloc>().close();
      context.read<AuthenticationBloc>().add(const Logout());
    }

    final title = context.select<DailyCartoonBloc, String>(
      (DailyCartoonBloc bloc) {
        final state = bloc.state;
        if (state is DailyCartoonLoaded) {
          return DateFormat.yMMMMEEEEd(Platform.localeName)
            .format(state.dailyCartoon.timestamp.toDate());
        }
        return ' ';
      }
    );

    final _isLoading = context.select<DailyCartoonBloc, bool>(
      (bloc) => bloc.state is DailyCartoonInProgress
    );

    return Scaffold(
      appBar: AppBar(
        leading: Semantics(
          child: CustomIconButton(
            label: 'Logout button',
            hint: 'Tap to logout',
            key: const Key('DailyCartoonView_Button_Logout'),
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: _logout,
          ),
        ),
        title: Semantics(
          label: title == ' ' ? '' : 'The image was posted on $title',
          child: ScaffoldTitle(title: title)
        ),
        centerTitle: true
      ),
      body: CartoonScrollBar(
        child: SingleChildScrollView(
          physics: _isLoading
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
          child: const PoliticalCartoonView(),
        ),
      ),
    );
  }
}

class PoliticalCartoonView extends StatelessWidget {
  const PoliticalCartoonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Semantics(
          excludeSemantics: true,
          child: const PageHeader(header: 'Latest')
        ),
        const SizedBox(height: 12),
        BlocBuilder<DailyCartoonBloc, DailyCartoonState>(
          builder: (context, state) {
            if (state is DailyCartoonInProgress) {
              return const CartoonBodyPlaceholder(
                key: Key('DailyCartoonView_DailyCartoonInProgress')
              );
            } else if (state is DailyCartoonLoaded) {
              return CartoonBody(
                key: const Key('DailyCartoonView_DailyCartoonLoaded'),
                cartoon: state.dailyCartoon
              );
            } else {
              return const SizedBox(
                key: Key('DailyCartoonView_DailyCartoonFailed')
              );
            }
          }
        ),
      ],
    );
  }
}

