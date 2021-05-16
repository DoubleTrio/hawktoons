import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/filtered_cartoons/view/details_page.dart';

class FilteredFlowPage extends Page {
  const FilteredFlowPage() : super(key: const ValueKey('FilteredFlowPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (_, __, ___) => const FilteredFlow(),
      transitionDuration: const Duration(milliseconds: 1000),
    );
  }
}

class FilteredFlow extends StatelessWidget {

  const FilteredFlow({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<SelectPoliticalCartoonState>(
      state: context.watch<SelectCartoonCubit>().state,
      onGeneratePages: (SelectPoliticalCartoonState state, pages) {
        return [
          FilteredCartoonsPage(),
          if (state.cartoonSelected) DetailsPage(cartoon: state.cartoon!)
        ];
      }
    );
  }
}
