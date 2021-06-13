import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/widgets/widgets.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class StaggeredCartoonGrid extends StatefulWidget {
  const StaggeredCartoonGrid({Key? key}) : super(key: key);

  @override
  _StaggeredCartoonGridState createState() => _StaggeredCartoonGridState();
}

class _StaggeredCartoonGridState extends State<StaggeredCartoonGrid> {
  late ScrollController _scrollController;
  late Completer<void> _refreshCompleter;

  final delta = 200.0;

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final height = 30;

      _scrollController.addListener(() {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;

        if (currentScroll > height) {
          context.read<AllCartoonsPageCubit>().onScrollPastHeader();
        } else {
          context.read<AllCartoonsPageCubit>().onScrollBeforeHeader();
        }

        if ((maxScroll - currentScroll <= delta) && currentScroll > 0) {
          context.read<AllCartoonsBloc>().add(const LoadMoreCartoons());
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
    _refreshCompleter.complete();
    super.dispose();
  }

  Widget _buildInitialIndicator() {
    return const LoadingIndicator(
      key: Key('AllCartoonsPage_AllCartoonsLoading')
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final _isLoadingMore = context.select<AllCartoonsBloc, bool>(
      (value) => value.state.status == CartoonStatus.loadingMore
    );

    final _isLoadingInitial = context.select<AllCartoonsBloc, bool>(
      (value) => value.state.status == CartoonStatus.initial
    );

    final _isLoadingInitialError = context.select<AllCartoonsBloc, bool>(
      (value) => value.state.status == CartoonStatus.failure
    );

    void _selectCartoon(PoliticalCartoon cartoon) {
      context.read<AllCartoonsPageCubit>().selectCartoon(cartoon);
    }

    Future<void> _refresh() async {
      context.read<AllCartoonsBloc>().add(const RefreshCartoons());
      return _refreshCompleter.future.timeout(
        const Duration(seconds: 20),
      );
    }

    void _restartCompleter() {
      _refreshCompleter.complete();
      _refreshCompleter = Completer();
    }

    Widget _buildInitialErrorIndicator() {
      return SizedBox(
        height: 30,
        width: double.infinity,
        child: Text(
          'An error has occurred while loading for images',
          key: const Key('AllCartoonsPage_AllCartoonsFailed'),
          style: theme.textTheme.bodyText1!.copyWith(
            color: theme.colorScheme.error
          ),
        ),
      );
    }

    return RefreshIndicator(
      backgroundColor: theme.bottomAppBarColor,
      onRefresh: _refresh,
      child: AppScrollBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ThemeConstants.sPadding),
          child: BlocConsumer<AllCartoonsBloc, AllCartoonsState>(
            listener: (context, state) {
              if (state.status == CartoonStatus.refreshSuccess) {
                _restartCompleter();
              }

              if (state.status == CartoonStatus.refreshFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text(l10n.allCartoonsRefreshErrorText),
                  ),
                );
                _restartCompleter();
              }
            },
            buildWhen: (prev, curr) =>
              prev.cartoons != curr.cartoons ||
              prev.view != curr.view,
            builder: (context, state) {
              final _itemCount = state.cartoons.length + 2;
              final view = state.view;
              return Semantics(
                label: l10n.allCartoonsPageScrollLabel,
                hint: l10n.allCartoonsPageScrollHint,
                child: StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()
                  ),
                  crossAxisCount: 2,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 3.0,
                  itemCount: _itemCount,
                  itemBuilder: (context, index) {
                    final isFirstItem = index == 0;
                    final isLastItem = index == _itemCount - 1;
                    if (isFirstItem) {
                      return Column(
                        children: [
                          if (_isLoadingInitial)
                            _buildInitialIndicator(),
                          PageHeader(
                            header: l10n.allCartoonsPageHeaderText,
                          ),

                          if (_isLoadingInitialError)
                            _buildInitialErrorIndicator(),
                        ]
                      );
                    }
                    if (isLastItem) {
                      if (_isLoadingMore) {
                        return const LoadingIndicator(
                          key: Key('StaggeredCartoonGrid_LoadingMoreIndicator')
                        );
                      }
                      return const SizedBox.shrink();
                    }

                    final cartoon = state.cartoons[index - 1];

                    void onTap() {
                      _selectCartoon(cartoon);
                    }

                    switch(state.view) {
                      case CartoonView.staggered:
                        return StaggeredCartoonCard(
                          key: Key('StaggeredCartoonCard_${cartoon.id}'),
                          cartoon: cartoon,
                          onTap: onTap,
                        );
                      case CartoonView.card:
                        return CartoonCard(
                          key: Key('CartoonCard_${cartoon.id}'),
                          cartoon: cartoon,
                          onTap: onTap,
                        );
                    }
                  },
                  staggeredTileBuilder: (index) {
                    final isFirstItem = index == 0;
                    final isLastItem = index == _itemCount - 1;
                    return StaggeredTile.fit(
                      isFirstItem ||
                      isLastItem ||
                      view != CartoonView.staggered ? 2 : 1
                    );
                  }
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}