import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/all_cartoons/flow/filtered_flow.dart';
import 'package:history_app/test_page.dart';
import 'package:history_app/widgets/tab_selector.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class HomeFlowPage extends Page {
  const HomeFlowPage() : super(key: const ValueKey('HomeFlowPage'));

  @override
  Route createRoute(BuildContext context) {
    final _firebaseCartoonRepo =
      context.read<FirestorePoliticalCartoonRepository>();
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
        MultiBlocProvider(providers: [
          BlocProvider<TabBloc>(create: (_) => TabBloc(),),
          BlocProvider<ImageTypeCubit>(create: (_) => ImageTypeCubit()),
          BlocProvider<TagCubit>(create: (_) => TagCubit()),
          BlocProvider<ScrollHeaderCubit>(create: (_) => ScrollHeaderCubit()),
          BlocProvider<SortByCubit>(create: (_) => SortByCubit()),
          BlocProvider(create: (_) => SelectCartoonCubit()),
          BlocProvider(create: (_) => ShowBottomSheetCubit()),
          BlocProvider<DailyCartoonBloc>(
            create: (_) => DailyCartoonBloc(
              dailyCartoonRepository: _firebaseCartoonRepo
            )..add(LoadDailyCartoon())),
          BlocProvider<AllCartoonsBloc>(create: (context) {
            final _sortByMode = context.read<SortByCubit>().state;
            final _tag = context.read<TagCubit>().state;
            final _imageType = context.read<ImageTypeCubit>().state;
            final filters = CartoonFilters(
              sortByMode: _sortByMode,
              imageType: _imageType,
              tag: _tag
            );
            return AllCartoonsBloc(cartoonRepository: _firebaseCartoonRepo)
              ..add(LoadAllCartoons(filters));
          }),
        ],
          child: const HomeFlow()
      ),
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end)
          ..chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
    );
  }
}

class HomeFlow extends StatelessWidget {
  const HomeFlow({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var activeTab = context.watch<TabBloc>().state;
    return WillPopScope(
      onWillPop: () async {
        context.read<AuthenticationBloc>().add(Logout());
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: TabSelector(
          activeTab: activeTab,
          onTabSelected: (tab) =>
            BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
        ),
        body: BlocListener<ShowBottomSheetCubit, bool>(
          listener: (context, shouldShowBottomSheet) {
            if (shouldShowBottomSheet) {
              var _imageTypeCubit = context.read<ImageTypeCubit>();
              var _tagCubit = context.read<TagCubit>();
              var _sortByCubit = context.read<SortByCubit>();
              var _allCartoonsBloc = context.read<AllCartoonsBloc>();
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20)),
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
                }).whenComplete(
                  () => context.read<ShowBottomSheetCubit>().closeSheet()
                );
            }
          },
          child: FlowBuilder<AppTab>(
            state: context.watch<TabBloc>().state,
            onGeneratePages: (AppTab state, pages) {
              switch (state) {
                case AppTab.daily:
                  return [const DailyCartoonPage(), TestPagePage()];
                default:
                  return [const FilteredFlowPage()];
              }
            }
          ),
        ),
      ),
    );
  }
}
