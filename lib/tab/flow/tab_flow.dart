import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/latest_cartoon/latest_cartoon.dart';
import 'package:hawktoons/settings/flow/settings_flow.dart';
import 'package:hawktoons/tab/tab.dart';

class TabFlow extends StatelessWidget {
  const TabFlow({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final _activeTab = context.watch<TabBloc>().state;

    void _closeSheet() {
      context.read<ShowBottomSheetCubit>().closeSheet();
    }

    void _onTabChanged(AppTab tab) {
      context.read<TabBloc>().add(UpdateTab(tab));
    }

    return Scaffold(
      bottomNavigationBar: Semantics(
        label: 'Bottom tab bar',
        child: TabSelector(
          activeTab: _activeTab,
          onTabChanged: _onTabChanged,
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
              case AppTab.latest:
                return [const DailyCartoonPage()];
              case AppTab.all:
                return [const CartoonFlowPage()];
              default:
                return [const SettingsFlowPage()];
            }
          }
        ),
      ),
    );
  }
}
