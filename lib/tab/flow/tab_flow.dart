import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:hawktoons/latest_cartoon/latest_cartoon.dart';
import 'package:hawktoons/settings/flow/settings_flow.dart';
import 'package:hawktoons/tab/tab.dart';

class TabFlow extends StatelessWidget {
  const TabFlow({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final _activeTab = context.watch<TabBloc>().state;

    void _closeFilterSheet() {
      context.read<AllCartoonsPageCubit>().closeFilterSheet();
    }

    void _closeCartoonSheet() {
      context.read<AllCartoonsPageCubit>().closeCreateCartoonSheet();
    }

    void _onTabChanged(AppTab tab) {
      context.read<TabBloc>().add(UpdateTab(tab));
    }

    Future<void> showBottomSheet({
      required Widget child,
      required VoidCallback onComplete
    }) {

      return showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return child;
        }
      ).whenComplete(onComplete);
    }

    return Scaffold(
      bottomNavigationBar: TabSelector(
        activeTab: _activeTab,
        onTabChanged: _onTabChanged,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AllCartoonsPageCubit, AllCartoonsPageState>(
            listener: (context, state) {
              if (state.shouldShowFilterSheet) {
                final _allCartoonsBloc = context.read<AllCartoonsBloc>();
                final _filterSheetCubit = context.read<FilterSheetCubit>();
                showBottomSheet(
                  onComplete: _closeFilterSheet,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: _allCartoonsBloc),
                      BlocProvider.value(value: _filterSheetCubit),
                    ],
                    child: FilterSheet()
                  ),
                );
              }
              if (state.shouldShowCreateCartoonSheet) {
                final _createCartoonSheetBloc = CreateCartoonSheetBloc();
                showBottomSheet(
                  onComplete: _closeCartoonSheet,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: _createCartoonSheetBloc),
                    ],
                    child: const CreateCartoonPopUp()
                  ),
                );
              }
            },
          ),
        ],
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
      )
    );
  }
}
