import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/all_cartoons/blocs/blocs.dart';
import 'package:history_app/all_cartoons/widgets/widgets.dart';
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
        const FilteredCartoonsScreen(),
      transitionDuration: const Duration(milliseconds: 800),
    );
  }
}

class FilteredCartoonsScreen extends StatelessWidget {
  const FilteredCartoonsScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var shouldDisplayTitle = context.watch<ScrollHeaderCubit>().state;
    return Scaffold(
      appBar: AppBar(
          leading: CustomIconButton(
            key: const Key('FilteredCartoonsPage_LogoutButton'),
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () => context.read<AuthenticationBloc>().add(Logout()),
          ),
          title: AnimatedOpacity(
            opacity: shouldDisplayTitle ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: const ScaffoldTitle(
              title: 'All Images',
            ),
          ),
          centerTitle: true,
          actions: [
            CustomIconButton(
              key: const Key('FilteredCartoonsPage_FilterButton'),
              icon: const Icon(Icons.filter_list),
              onPressed: () => context.read<ShowBottomSheetCubit>().openSheet(),
            )
          ]),
      body: Column(
        children: [
          BlocBuilder<AllCartoonsBloc, AllCartoonsState>(
            builder: (context, state) {
              if (state.status == CartoonStatus.initial) {
                return Column(
                  key:
                    const Key('FilteredCartoonsPage_FilteredCartoonsLoading'),
                  children: [
                    const SizedBox(height: 24),
                    const LoadingIndicator(),
                  ],
                );
              }
              if (state.status == CartoonStatus.success || state.status == CartoonStatus.loading) {
                return StaggeredCartoonGrid(
                  cartoons: [
                    ...state.cartoons,
                  ],
                  key: const Key('FilteredCartoonsPage_FilteredCartoonsLoaded'),
                );
              }
              return const Text('Error',
                key: Key('FilteredCartoonsPage_FilteredCartoonsFailed')
              );
            },
          ),
        ],
      ),
    );
  }
}
