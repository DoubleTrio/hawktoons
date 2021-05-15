import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon_bloc.dart';
import 'package:history_app/widgets/cartoon_body.dart';
import 'package:history_app/widgets/custom_icon_button.dart';
import 'package:history_app/widgets/loading_indicator.dart';
import 'package:history_app/widgets/page_header.dart';
import 'package:history_app/widgets/scaffold_title.dart';
import 'package:intl/intl.dart';

class DailyCartoonPage extends Page {
  DailyCartoonPage() : super(key: const ValueKey('DailyCartoonPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
        DailyCartoonScreen(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class DailyCartoonScreen extends StatelessWidget {
  DailyCartoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = context.select((DailyCartoonBloc bloc) {
      var state = bloc.state;
      if (state is DailyCartoonLoaded) {
        return DateFormat.yMMMMEEEEd(Platform.localeName)
          .format(state.dailyCartoon.timestamp.toDate());
      }
      return ' ';
    });
    return Scaffold(
      appBar: AppBar(
          leading: CustomIconButton(
            key: const Key('DailyCartoonScreen_Button_Logout'),
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () => context.read<AuthenticationBloc>().add(Logout()),
          ),
          title: ScaffoldTitle(title: title),
          centerTitle: true),
      body: SingleChildScrollView(
        child: PoliticalCartoonCardLoader(),
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}

class PoliticalCartoonCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyCartoonBloc, DailyCartoonState>(
        builder: (context, state) {
      if (state is DailyCartoonInProgress) {
        return Column(
          key: const Key('DailyCartoonScreen_DailyCartoonInProgress'),
          children: [
            const SizedBox(height: 24),
            LoadingIndicator(),
          ],
        );
      } else if (state is DailyCartoonLoaded) {
        var cartoon = state.dailyCartoon;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          key: const Key('DailyCartoonScreen_DailyCartoonLoaded'),
          children: [
            PageHeader(header: 'Daily'),
            const SizedBox(height: 12),
            CartoonBody(cartoon: cartoon, addImagePadding: true),
          ],
        );
      } else {
        return const SizedBox(
          key: Key('DailyCartoonScreen_DailyCartoonFailed'));
      }
    });
  }
}
