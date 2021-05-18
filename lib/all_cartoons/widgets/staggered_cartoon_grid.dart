import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/widgets/cartoon_scroll_bar.dart';
import 'package:history_app/widgets/loading_indicator.dart';
import 'package:history_app/widgets/page_header.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class StaggeredCartoonGrid extends StatefulWidget {
  StaggeredCartoonGrid({Key? key, required this.cartoons}) : super(key: key);

  final List<PoliticalCartoon> cartoons;

  @override
  _StaggeredCartoonGridState createState() => _StaggeredCartoonGridState();
}

class _StaggeredCartoonGridState extends State<StaggeredCartoonGrid> {
  late ScrollController _scrollController;
  final _headerKey = GlobalKey();
  final delta = 200.0;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var renderBox =
          _headerKey.currentContext!.findRenderObject() as RenderBox;

      var height = renderBox.size.height;

      _scrollController.addListener(() {
        var maxScroll = _scrollController.position.maxScrollExtent;
        var currentScroll = _scrollController.position.pixels;

        if (currentScroll > height) {
          context.read<ScrollHeaderCubit>().onScrollPastHeader();
        } else {
          context.read<ScrollHeaderCubit>().onScrollBeforeHeader();
        }

        if (maxScroll - currentScroll <= delta) {
          final _selectedTag = context.read<TagCubit>().state;
          final _sortByMode = context.read<SortByCubit>().state;
          final _imageType = context.read<ImageTypeCubit>().state;
          final filters = CartoonFilters(
              sortByMode: _sortByMode,
              imageType: _imageType,
              tag: _selectedTag);
          context.read<AllCartoonsBloc>().add(LoadMoreCartoons(filters));
        }
      });
      _scrollController.position.isScrollingNotifier.addListener(() {
        if (_scrollController.position.isScrollingNotifier.value) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var itemCount = widget.cartoons.length + 2;
    var isLoading = context.select<AllCartoonsBloc, bool>(
        (value) => value.state.status == CartoonStatus.loading);

    return Expanded(
      child: CartoonScrollBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == 0) {
                return PageHeader(
                  header: 'All',
                  key: _headerKey,
                );
              }

              if (index == itemCount - 1) {
                if (isLoading) {
                  return const LoadingIndicator(
                      key: Key('StaggeredCartoonGrid_LoadingIndicator'));
                } else {
                  return const SizedBox.shrink();
                }
              }

              var cartoon = widget.cartoons[index - 1];
              return CartoonCard(
                key: Key('CartoonCard_${cartoon.id}'),
                cartoon: cartoon,
                onTap: () =>
                    context.read<SelectCartoonCubit>().selectCartoon(cartoon),
              );
            },
            staggeredTileBuilder: (index) =>
                StaggeredTile.fit(index == 0 || index == itemCount - 1 ? 2 : 1),
          ),
        ),
      ),
    );
  }
}
