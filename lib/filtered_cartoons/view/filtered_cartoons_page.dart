import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/widgets/widgets.dart';
import 'package:history_app/widgets/widgets.dart';

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
          leading: SignOutIcon(
            onPressed: () => context.read<AuthenticationBloc>().add(Logout()),
            size: 25,
          ),
          actions: [
            FilterIcon(
              onPressed: () => context.read<ShowBottomSheetCubit>().openSheet(),
              size: 25,
            ),
          ]),
      body: Column(
        children: [
          // Container(
          //   color: Colors.grey,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [],
          //   ),
          // ),
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
