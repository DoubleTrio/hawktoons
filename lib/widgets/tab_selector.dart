import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/home/blocs/blocs.dart';
import 'package:history_app/theme/theme.dart';

class TabSelector extends StatelessWidget {
  TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  final int totalTabs = AppTab.values.length;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final middleTabWidth = screenWidth * 0.20;
    final width = screenWidth / totalTabs - (middleTabWidth / totalTabs);
    return Row(children: [
      CustomBottomTabItem(
          key: const Key('TabSelector_DailyTab'),
          icon: const Icon(Icons.article_outlined),
          label: 'Latest',
          width: width,
          onTap: () => onTabSelected(AppTab.daily),
          selected: AppTab.daily == activeTab),
      CustomBottomTabItem(
          key: const Key('TabSelector_ChangeTheme'),
          icon: const Icon(Icons.lightbulb_outline),
          width: middleTabWidth,
          onTap: () => context.read<ThemeCubit>().changeTheme(),
          selected: false),
      CustomBottomTabItem(
          key: const Key('TabSelector_AllTab'),
          icon: const Icon(Icons.list),
          label: 'All',
          width: width,
          onTap: () => onTabSelected(AppTab.all),
          selected: AppTab.all == activeTab),
    ]);
  }
}

class CustomBottomTabItem extends StatelessWidget {
  CustomBottomTabItem(
      {Key? key,
      required this.icon,
      this.label,
      required this.width,
      required this.onTap,
      required this.selected})
      : super(key: key);

  final Widget icon;
  final String? label;
  final double width;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final height = MediaQuery.of(context).size.height * 0.07;

    return InkWell(
      onTap: onTap,
      child: Ink(
        color: theme.bottomNavigationBarTheme.backgroundColor,
        child: Container(
          height: height,
          width: width,
          decoration: selected
              ? BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 3, color: colorScheme.primary)))
              : const BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              if (label != null)
                Text(label!,
                    style: selected
                        ? theme.bottomNavigationBarTheme.selectedLabelStyle
                        : theme.bottomNavigationBarTheme.unselectedLabelStyle),
            ],
          ),
        ),
      ),
    );
  }
}
