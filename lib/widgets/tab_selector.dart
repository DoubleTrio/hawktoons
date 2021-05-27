import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hawktoons/home/blocs/blocs.dart';

class TabSelector extends StatelessWidget {
  TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabChanged,
    required this.onThemeChanged,
  }) : super(key: key);

  final AppTab activeTab;
  final ValueChanged<AppTab> onTabChanged;
  final VoidCallback onThemeChanged;

  final int totalTabs = AppTab.values.length;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final middleTabWidth = screenWidth * 0.20;
    final width = screenWidth / totalTabs - (middleTabWidth / totalTabs);

    return Row(children: [
      Semantics(
        sortKey: const OrdinalSortKey(0),
        button: true,
        label: 'Latest political images tab',
        hint: 'Navigate to latest image',
        child: CustomBottomTabItem(
          key: const Key('TabSelector_DailyTab'),
          icon: const Icon(Icons.article_outlined),
          label: 'Latest',
          width: width,
          onTap: () => onTabChanged(AppTab.daily),
          selected: AppTab.daily == activeTab
        ),
      ),
      Semantics(
        sortKey: const OrdinalSortKey(2),
        button: true,
        label: 'Change theme tab button',
        hint: 'Press to switch between light and dark theme',
        child: CustomBottomTabItem(
          key: const Key('TabSelector_ChangeTheme'),
          icon: const Icon(Icons.lightbulb_outline),
          width: middleTabWidth,
          onTap: onThemeChanged,
          selected: false
        ),
      ),
      Semantics(
        sortKey: const OrdinalSortKey(1),
        button: true,
        label: 'All political images tab',
        hint: 'Navigate to all posted political images',
        child: CustomBottomTabItem(
          key: const Key('TabSelector_AllTab'),
          icon: const Icon(Icons.list),
          label: 'All',
          width: width,
          onTap: () => onTabChanged(AppTab.all),
          selected: AppTab.all == activeTab
        ),
      ),
    ]);
  }
}

class CustomBottomTabItem extends StatelessWidget {
  CustomBottomTabItem({Key? key,
    required this.icon,
    this.label,
    required this.width,
    required this.onTap,
    required this.selected
  }) : super(key: key);

  final Widget icon;
  final String? label;
  final double width;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomNavTheme = theme.bottomNavigationBarTheme;
    final colorScheme = theme.colorScheme;
    final height = MediaQuery.of(context).size.height * 0.07;

    return InkWell(
      onTap: onTap,
      child: Ink(
        color: bottomNavTheme.backgroundColor,
        child: Container(
          height: height,
          width: width,
          decoration: selected
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(width: 3, color: colorScheme.primary)
                )
              )
            : const BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              if (label != null)
                Text(
                  label!,
                  style: selected
                    ? bottomNavTheme.selectedLabelStyle
                    : bottomNavTheme.unselectedLabelStyle
                ),
            ],
          ),
        ),
      ),
    );
  }
}
