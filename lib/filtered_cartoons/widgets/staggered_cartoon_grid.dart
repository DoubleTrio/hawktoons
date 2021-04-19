import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class StaggeredCartoonGrid extends StatelessWidget {
  StaggeredCartoonGrid({required this.cartoons});

  final List<PoliticalCartoon> cartoons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 8.0,
        itemCount: cartoons.length,
        itemBuilder: (context, index) {
          var cartoon = cartoons[index];
          return CartoonCard(
            cartoon: cartoon,
            onTap: () => Navigator.pushNamed(
                context, '${AppTab.all.routeName}/${cartoon.id}',
                arguments: cartoon),
          );
        },
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      ),
    );
  }
}
