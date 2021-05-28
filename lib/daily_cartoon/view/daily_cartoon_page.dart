import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:hawktoons/widgets/widgets.dart';
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

    void _openDrawer() {
      context.read<AppDrawerCubit>().openDrawer();
    }

    return Scaffold(
      appBar: AppBar(
        leading: Semantics(
          child: CustomIconButton(
            label: 'Open drawer button',
            hint: 'Tap to open the side drawer',
            key: const Key('DailyCartoonView_OpenDrawer'),
            icon: const Icon(Icons.menu),
            onPressed: _openDrawer,
          ),
        ),
        title: Semantics(
          label: title == ' ' ? '' : 'The image was posted on $title',
          child: ScaffoldTitle(title: title)
        ),
        centerTitle: true
      ),
      body: AppScrollBar(
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

