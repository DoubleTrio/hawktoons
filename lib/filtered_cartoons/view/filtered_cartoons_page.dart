import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/filtered_cartoons/widgets/filter_icon.dart';

class FilteredCartoonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Cartoons'),
        actions: [
          FilterIcon(
            key: const Key('FilteredCartoonsPage_FilterIcon'),
          )
        ],
      ),
      body: BlocBuilder<FilteredCartoonsBloc, FilteredCartoonsState>(
        builder: (context, state) {
          if (state is FilteredCartoonsLoading) {
            return const Center(
                key: Key('FilteredCartoonsPage_FilteredCartoonsLoading'),
                child: CircularProgressIndicator());
          } else if (state is FilteredCartoonsLoaded) {
            return Column(
              key: const Key('FilteredCartoonsPage_FilteredCartoonsLoaded'),
              children: [
                StaggeredCartoonGrid(cartoons: state.filteredCartoons)
              ],
            );
          } else {
            return const Text('Error',
                key: Key('FilteredCartoonsPage_FilteredCartoonsFailed'));
          }
        },
      ),
    );
  }
}
