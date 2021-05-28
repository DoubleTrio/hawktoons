import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/cubit/app_drawer_cubit.dart';
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
    final _shouldDisplayTitle = context.watch<ScrollHeaderCubit>().state;

    void _openFilterSheet() {
      context.read<ShowBottomSheetCubit>().openSheet();
    }

    void _openDrawer() {
      context.read<AppDrawerCubit>().openDrawer();
    }

    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          label: 'Open drawer button',
          hint: 'Tap to open the side drawer',
          key: const Key('AllCartoonsView_OpenDrawer'),
          icon: const Icon(Icons.menu),
          onPressed: _openDrawer,
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
        child: const StaggeredCartoonGrid(
          key: Key('AllCartoonsPage_AllCartoonsLoaded'),
        ),
      ),
    );
  }
}
