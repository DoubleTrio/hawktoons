import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/filtered_cartoons/view/details_page.dart';

class FilteredFlowPage extends Page {
  FilteredFlowPage() : super(key: const ValueKey('FilteredFlowPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => FilteredFlow(),
      transitionDuration: const Duration(milliseconds: 1000),
    );
  }
}

class FilteredFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlowBuilder<SelectPoliticalCartoonState>(
        state: context.watch<SelectCartoonCubit>().state,
        onGeneratePages: (SelectPoliticalCartoonState state, pages) {
          return [
            FilteredCartoonsPage(),
            if (state.cartoon != null) DetailsPage(cartoon: state.cartoon!)
          ];
        });
  }
}
