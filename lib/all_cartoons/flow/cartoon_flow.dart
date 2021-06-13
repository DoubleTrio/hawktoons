import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';

class CartoonFlowPage extends Page<void> {
  const CartoonFlowPage() : super(key: const ValueKey('CartoonFlowPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (_, __, ___) => const CartoonFlow(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class CartoonFlow extends StatelessWidget {
  const CartoonFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectCartoonState = context.select<AllCartoonsPageCubit,
      SelectPoliticalCartoonState>(
      (cubit) => cubit.state.politicalCartoon
    );
    return FlowBuilder<SelectPoliticalCartoonState>(
      state: selectCartoonState,
      onGeneratePages: (SelectPoliticalCartoonState state, pages) {
        return [
          AllCartoonsPage(),
          if (state.cartoonSelected) DetailsPage(cartoon: state.cartoon!)
        ];
      }
    );
  }
}
