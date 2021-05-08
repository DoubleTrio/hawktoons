import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/widgets/widgets.dart';
import 'package:history_app/widgets/custom_icon_button.dart';

class FilteredCartoonsPage extends Page {
  FilteredCartoonsPage() : super(key: const ValueKey('FilteredCartoonsPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FilteredCartoonsScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}

class FilteredCartoonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          leading: CustomIconButton(
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () => context.read<AuthenticationBloc>().add(Logout()),
          ),
          actions: [
            CustomIconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => context.read<ShowBottomSheetCubit>().openSheet(),
            ),
          ]),
      body: Column(
        children: [
          BlocBuilder<FilteredCartoonsBloc, FilteredCartoonsState>(
            builder: (context, state) {
              if (state is FilteredCartoonsLoading) {
                return const Center(
                    key: Key('FilteredCartoonsPage_FilteredCartoonsLoading'),
                    child: CircularProgressIndicator());
              } else if (state is FilteredCartoonsLoaded) {
                return StaggeredCartoonGrid(
                  cartoons: [
                    ...state.filteredCartoons,
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
