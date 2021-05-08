import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/widgets/page_header.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class StaggeredCartoonGrid extends StatelessWidget {
  StaggeredCartoonGrid({Key? key, required this.cartoons}) : super(key: key);

  final List<PoliticalCartoon> cartoons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StaggeredGridView.countBuilder(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 8.0,
        itemCount: cartoons.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return PageHeader(header: 'All');
          }

          var cartoon = cartoons[index - 1];
          return CartoonCard(
            cartoon: cartoon,
            onTap: () =>
                context.read<SelectCartoonCubit>().selectCartoon(cartoon),
          );
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(index == 0 ? 2 : 1),
      ),
    );
  }
}
