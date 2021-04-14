import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/filtered_cartoons/widgets/filter_icon.dart';

class FilteredCartoonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredCartoonsBloc, FilteredCartoonsState>(
      builder: (context, state) {
        if (state is FilteredCartoonsLoading) {
          return const Center(
              key: Key('FilteredCartoonsPage_FilteredCartoonsLoading'),
              child: CircularProgressIndicator());
        } else if (state is FilteredCartoonsLoaded) {
          return Column(
            key: const Key('FilteredCartoonsPage_FilteredCartoonsLoaded'),
            children: [
              FilterIcon(),
              StaggeredCartoonGrid(cartoons: state.filteredCartoons)
            ],
          );
        } else {
          return const Text('Error',
              key: Key('FilteredCartoonsPage_FilteredCartoonsFailed'));
        }
      },
    );
  }
}
