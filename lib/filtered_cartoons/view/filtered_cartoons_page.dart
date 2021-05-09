import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/widgets/widgets.dart';
import 'package:history_app/widgets/custom_icon_button.dart';
import 'package:history_app/widgets/loading_indicator.dart';
import 'package:history_app/widgets/scaffold_title.dart';

class FilteredCartoonsPage extends Page {
  FilteredCartoonsPage() : super(key: const ValueKey('FilteredCartoonsPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FilteredCartoonsScreen(),
      transitionDuration: const Duration(milliseconds: 800),
    );
  }
}

class FilteredCartoonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var shouldDisplayTitle = context.watch<ScrollHeaderCubit>().state;
    return Scaffold(
      appBar: AppBar(
          leading: CustomIconButton(
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () => context.read<AuthenticationBloc>().add(Logout()),
          ),
          title: AnimatedOpacity(
            opacity: shouldDisplayTitle ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: ScaffoldTitle(
              title: 'All Cartoons',
            ),
          ),
          centerTitle: true,
          actions: [
            CustomIconButton(
              key: const Key('FilteredCartoonsPage_FilterIcon'),
              icon: const Icon(Icons.filter_list),
              onPressed: () => context.read<ShowBottomSheetCubit>().openSheet(),
            )
          ]),
      body: Column(
        children: [
          BlocBuilder<FilteredCartoonsBloc, FilteredCartoonsState>(
            builder: (context, state) {
              if (state is FilteredCartoonsLoading) {
                return Column(
                  key:
                      const Key('FilteredCartoonsPage_FilteredCartoonsLoading'),
                  children: [
                    const SizedBox(height: 24),
                    LoadingIndicator(),
                  ],
                );
              } else if (state is FilteredCartoonsLoaded) {
                return StaggeredCartoonGrid(
                  cartoons: [
                    ...state.filteredCartoons,
                    ...state.filteredCartoons,
                    ...state.filteredCartoons
                  ],
                  key: const Key('FilteredCartoonsPage_FilteredCartoonsLoaded'),
                );
              } else {
                return const Text('Error',
                    key: Key('FilteredCartoonsPage_FilteredCartoonsFailed'));
              }
            },
          ),
        ],
      ),
    );
  }
}
