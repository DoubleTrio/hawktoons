import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/widgets/add_floating_action_button.dart';
import 'package:hawktoons/widgets/widgets.dart';

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
    final l10n = context.l10n;
    final shouldDisplayTitle = context
      .watch<ScrollHeaderCubit>()
      .state;

    final isAdmin = context.select<AuthenticationBloc, bool>(
      (bloc) => bloc.state.isAdmin
    );

    void _openCreateCartoonSheet() {
      context.read<ShowCreateCartoonSheetCubit>().openSheet();
    }

    void _openFilterSheet() {
      context.read<ShowFilterBottomSheetCubit>().openSheet();
    }

    void _openDrawer() {
      context.read<AppDrawerCubit>().openDrawer();
    }


    return Scaffold(
      floatingActionButton: isAdmin ?
        AddFloatingActionButton(
          label: l10n.allCartoonsPageFloatingActionButtonLabel,
          hint: l10n.allCartoonsPageFloatingActionButtonHint,
          onPressed: _openCreateCartoonSheet
        )
        : null,
      appBar: AppBar(
        leading: CustomIconButton(
          key: const Key('AllCartoonsView_OpenDrawer'),
          label: l10n.openDrawerLabel,
          hint: l10n.openDrawerHint,
          icon: const Icon(Icons.menu),
          onPressed: _openDrawer,
        ),
        title: Semantics(
          excludeSemantics: true,
          child: AnimatedOpacity(
            opacity: shouldDisplayTitle ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: ScaffoldTitle(
              title: l10n.allCartoonsPageScaffoldText,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            key: const Key('AllCartoonsPage_FilterButton'),
            label: l10n.openFiltersPageLabel,
            hint: l10n.openFiltersPageHint,
            icon: const Icon(Icons.filter_list),
            onPressed: _openFilterSheet,
          )
        ]
      ),
      body: BlocListener<AllCartoonsBloc, AllCartoonsState>(
        listenWhen: (prev, curr) => prev.filters != curr.filters,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(l10n.allCartoonsPageSnackBarFilterText),
            ),
          );
        },
        child: const StaggeredCartoonGrid(
          key: Key('AllCartoonsPage_AllCartoonsLoaded'),
        ),
      ),
    );
  }
}
