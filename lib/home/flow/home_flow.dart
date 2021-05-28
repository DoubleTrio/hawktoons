import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/daily_cartoon/daily_cartoon.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:hawktoons/theme/theme.dart';

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
        child: Container(
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
      ),
    );
  }
}
