import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/all_cartoons/flow/cartoon_flow.dart';
import 'package:hawktoons/daily_cartoon/daily_cartoon.dart';
import 'package:hawktoons/home/blocs/blocs.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:hawktoons/widgets/tab_selector.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class HomeFlowPage extends Page<void> {
  const HomeFlowPage() : super(key: const ValueKey('HomeFlowPage'));

  @override
  Route createRoute(BuildContext context) {
    final _firebaseCartoonRepo =
      context.read<FirestorePoliticalCartoonRepository>();
    final _tabBloc = TabBloc();
    final _sortByCubit = SortByCubit();
    final _imageTypeCubit = ImageTypeCubit();
    final _tagCubit = TagCubit();
    final _scrollHeaderCubit = ScrollHeaderCubit();
    final _selectCartoonCubit = SelectCartoonCubit();
    final _showBottomSheetCubit = ShowBottomSheetCubit();
    final _dailyCartoonBloc = DailyCartoonBloc(
      dailyCartoonRepository: _firebaseCartoonRepo
    );
    final _allCartoonsBloc = AllCartoonsBloc(
      cartoonRepository: _firebaseCartoonRepo
    );

    final _sortByMode = _sortByCubit.state;
    final _imageType = _imageTypeCubit.state;
    final _tag = _tagCubit.state;
    final filters = CartoonFilters(
      sortByMode: _sortByMode,
      imageType: _imageType,
      tag: _tag
    );

    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _tabBloc),
            BlocProvider.value(value: _imageTypeCubit),
            BlocProvider.value(value: _tagCubit),
            BlocProvider.value(value: _sortByCubit),
            BlocProvider.value(value: _scrollHeaderCubit),
            BlocProvider.value(value: _selectCartoonCubit),
            BlocProvider.value(value: _showBottomSheetCubit),
            BlocProvider.value(value: _dailyCartoonBloc
              ..add(const LoadDailyCartoon())),
            BlocProvider.value(value: _allCartoonsBloc
              ..add(LoadCartoons(filters))),
          ],
          child: const HomeFlow()
        ),
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = const Offset(0.0, 1.0);
        final end = Offset.zero;
        final curve = Curves.ease;

        final tween = Tween(begin: begin, end: end)
          ..chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
  }
}

class HomeFlow extends StatelessWidget {
  const HomeFlow({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeTab = context.watch<TabBloc>().state;

    void _closeSheet() {
      context.read<ShowBottomSheetCubit>().closeSheet();
    }

    void _changeTheme() {
      context.read<ThemeCubit>().changeTheme();
    }

    void _onTabChanged(AppTab tab) {
      context.read<TabBloc>().add(UpdateTab(tab));
    }

    return Scaffold(
      bottomNavigationBar: Semantics(
        label: 'Bottom tab bar',
        child: TabSelector(
          activeTab: activeTab,
          onTabChanged: _onTabChanged,
          onThemeChanged: _changeTheme,
        ),
      ),
      body: BlocListener<ShowBottomSheetCubit, bool>(
        listener: (context, shouldShowBottomSheet) {
          if (shouldShowBottomSheet) {
            final _imageTypeCubit = context.read<ImageTypeCubit>();
            final _tagCubit = context.read<TagCubit>();
            final _sortByCubit = context.read<SortByCubit>();
            final _allCartoonsBloc = context.read<AllCartoonsBloc>();
            showModalBottomSheet<void>(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return MultiBlocProvider(providers: [
                  BlocProvider.value(value: _imageTypeCubit),
                  BlocProvider.value(value: _tagCubit),
                  BlocProvider.value(value: _sortByCubit),
                  BlocProvider.value(value: _allCartoonsBloc)
                ], child: FilterPopUp());
              }
            ).whenComplete(_closeSheet);
          }
        },
        child: FlowBuilder<AppTab>(
          state: context.watch<TabBloc>().state,
          onGeneratePages: (AppTab state, pages) {
            switch (state) {
              case AppTab.daily:
                return [const DailyCartoonPage()];
              default:
                return [const CartoonFlowPage()];
            }
          }
        ),
      ),
    );
  }
}
