import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/all_cartoons/blocs/blocs.dart';
import 'package:history_app/all_cartoons/widgets/widgets.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/widgets/custom_icon_button.dart';
import 'package:history_app/widgets/scaffold_title.dart';

class AllCartoonsPage extends Page<void> {
  AllCartoonsPage() : super(key: const ValueKey('AllCartoonsPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (_, __, ___) =>
        const AllCartoonsView(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class AllCartoonsView extends StatelessWidget {
  const AllCartoonsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _shouldDisplayTitle = context.watch<ScrollHeaderCubit>().state;

    void _logout() {
      context.read<AllCartoonsBloc>().close();
      context.read<DailyCartoonBloc>().close();
      context.read<AuthenticationBloc>().add(const Logout());
    }

    void _openFilterSheet() {
      context.read<ShowBottomSheetCubit>().openSheet();
    }

    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          label: 'Logout button',
          hint: 'Tap to logout',
          key: const Key('AllCartoonsPage_LogoutButton'),
          icon: const Icon(Icons.exit_to_app_rounded),
          onPressed: _logout,
        ),
        title: Semantics(
          excludeSemantics: true,
          child: AnimatedOpacity(
            opacity: _shouldDisplayTitle ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: const ScaffoldTitle(
              title: 'All Images',
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            label: 'Filter images button',
            hint: 'Tap to open the image filter page',
            key: const Key('AllCartoonsPage_FilterButton'),
            icon: const Icon(Icons.filter_list),
            onPressed: _openFilterSheet,
          )
        ]
      ),
      body: BlocListener<AllCartoonsBloc, AllCartoonsState>(
        listenWhen: (prev, curr) => prev.filters != curr.filters,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 2),
              content: Text('Filter applied!'),
            ),
          );
        },
        child: StaggeredCartoonGrid(
          key: const Key('AllCartoonsPage_AllCartoonsLoaded'),
        ),
      ),
    );
  }
}
