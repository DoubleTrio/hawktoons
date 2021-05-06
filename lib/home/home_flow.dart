import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/filtered_cartoons/view/filtered_flow.dart';
import 'package:history_app/widgets/tab_selector.dart';
import 'package:history_app/widgets/theme_floating_action_button.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class HomeFlow extends StatelessWidget {
  static Route<AppTab> route() {
    final _firebaseCartoonRepo = FirestorePoliticalCartoonRepository();
    return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(providers: [
              BlocProvider<TabBloc>(
                create: (_) => TabBloc(),
              ),
              BlocProvider<UnitCubit>(create: (_) => UnitCubit()),
              BlocProvider<SortByCubit>(create: (_) => SortByCubit()),
              BlocProvider(create: (_) => SelectCartoonCubit()),
              BlocProvider(create: (_) => ShowBottomSheetCubit()),
              BlocProvider<DailyCartoonBloc>(
                  create: (_) => DailyCartoonBloc(
                      dailyCartoonRepository: _firebaseCartoonRepo)
                    ..add(LoadDailyCartoon())),
              BlocProvider<AllCartoonsBloc>(create: (context) {
                final sortByMode = BlocProvider.of<SortByCubit>(context).state;
                return AllCartoonsBloc(cartoonRepository: _firebaseCartoonRepo)
                  ..add(LoadAllCartoons(sortByMode));
              }),
              BlocProvider(create: (context) {
                final _allCartoonsBloc =
                    BlocProvider.of<AllCartoonsBloc>(context);
                return FilteredCartoonsBloc(allCartoonsBloc: _allCartoonsBloc);
              }),
            ], child: HomeFlow()));
  }

  @override
  Widget build(BuildContext context) {
    var activeTab = context.watch<TabBloc>().state;
    return Scaffold(
      floatingActionButton: ThemeFloatingActionButton(),
      bottomNavigationBar: TabSelector(
          activeTab: activeTab,
          onTabSelected: (tab) => {
                BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
              }),
      body: BlocListener<ShowBottomSheetCubit, bool>(
        listener: (context, shouldShowBottomSheet) {
          if (shouldShowBottomSheet) {
            var _filteredCartoonsBloc =
                BlocProvider.of<FilteredCartoonsBloc>(context);
            var _unitCubit = BlocProvider.of<UnitCubit>(context);
            var _sortByCubit = BlocProvider.of<SortByCubit>(context);
            var _allCartoonsBloc = BlocProvider.of<AllCartoonsBloc>(context);
            showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return MultiBlocProvider(providers: [
                        BlocProvider.value(value: _unitCubit),
                        BlocProvider.value(value: _filteredCartoonsBloc),
                        BlocProvider.value(value: _sortByCubit),
                        BlocProvider.value(value: _allCartoonsBloc)
                      ], child: FilterPopUp());
                    })
                .whenComplete(
                    () => context.read<ShowBottomSheetCubit>().closeSheet());
          }
        },
        child: FlowBuilder<AppTab>(
            state: context.watch<TabBloc>().state,
            onGeneratePages: (AppTab state, pages) {
              switch (state) {
                case AppTab.daily:
                  return [DailyCartoonPage()];
                case AppTab.all:
                  return [FilteredFlowPage()];
                default:
                  return [DailyCartoonPage()];
              }
            }),
      ),
    );
  }
}
