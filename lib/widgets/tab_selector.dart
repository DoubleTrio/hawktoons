import 'package:flutter/material.dart';
import 'package:history_app/blocs/tab/tab.dart';

class TabSelector extends StatelessWidget {
  TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / AppTab.values.length;
    return Row(children: [
      CustomBottomTabItem(
          icon: const Icon(Icons.article_outlined,
              key: Key('TabSelector_DailyTab')),
          label: 'Daily',
          width: width,
          onTap: () => onTabSelected(AppTab.daily),
          selected: AppTab.daily == activeTab),
      CustomBottomTabItem(
          icon: const Icon(Icons.list, key: Key('TabSelector_AllTab')),
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
      required this.label,
      required this.width,
      required this.onTap,
      required this.selected})
      : super(key: key);

  final Widget icon;
  final String label;
  final double width;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      highlightColor: colorScheme.primary.withOpacity(0.1),
      splashColor: colorScheme.primary.withOpacity(0.1),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: width,
        decoration: selected
            ? BoxDecoration(
                color: theme.bottomNavigationBarTheme.backgroundColor,
                border: Border(
                    top: BorderSide(width: 3, color: colorScheme.primary)))
            : BoxDecoration(
                color: theme.bottomNavigationBarTheme.backgroundColor,
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(label,
                style: selected
                    ? theme.bottomNavigationBarTheme.selectedLabelStyle
                    : theme.bottomNavigationBarTheme.unselectedLabelStyle),
          ],
        ),
      ),
    );
  }
}
