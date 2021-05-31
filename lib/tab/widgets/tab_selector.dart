import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/tab/tab.dart';

class TabSelector extends StatelessWidget {
  TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabChanged,
  }) : super(key: key);

  final AppTab activeTab;
  final ValueChanged<AppTab> onTabChanged;

  final int totalTabs = AppTab.values.length;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth / totalTabs;

    return Row(
      children: [
        CustomBottomTabItem(
          key: const Key('TabSelector_LatestTab'),
          icon: const Icon(Icons.article_outlined),
          width: width,
          onTap: () => onTabChanged(AppTab.latest),
          selected: AppTab.latest == activeTab,
          text: l10n.appTabLatestText,
          label: l10n.appTabLatestLabel,
          hint: l10n.appTabLatestHint,
          sortKey: const OrdinalSortKey(0),
        ),
        CustomBottomTabItem(
          key: const Key('TabSelector_AllTab'),
          icon: const Icon(Icons.list),
          width: width,
          onTap: () => onTabChanged(AppTab.all),
          selected: AppTab.all == activeTab,
          text: l10n.appTabAllText,
          label: l10n.appTabAllLabel,
          hint: l10n.appTabAllHint,
          sortKey: const OrdinalSortKey(1),
        ),
        CustomBottomTabItem(
          key: const Key('TabSelector_SettingsTab'),
          icon: const Icon(Icons.settings_outlined),
          width: width,
          onTap: () => onTabChanged(AppTab.settings),
          selected: AppTab.settings == activeTab,
          text: l10n.appTabSettingsText,
          label: l10n.appTabSettingsLabel,
          hint: l10n.appTabSettingsHint,
          sortKey: const OrdinalSortKey(2),
        ),
      ]
    );
  }
}

class CustomBottomTabItem extends StatelessWidget {
  CustomBottomTabItem({Key? key,
    required this.icon,
    required this.text,
    required this.width,
    required this.onTap,
    required this.selected,
    required this.label,
    required this.hint,
    required this.sortKey,
  }) : super(key: key);

  final Widget icon;
  final String text;
  final double width;
  final VoidCallback onTap;
  final bool selected;
  final String label;
  final String hint;
  final OrdinalSortKey sortKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomNavTheme = theme.bottomNavigationBarTheme;
    final colorScheme = theme.colorScheme;
    final height = MediaQuery.of(context).size.height * 0.07;

    return Semantics(
      button: true,
      sortKey: sortKey,
      label: label,
      hint: hint,
      child: InkWell(
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
                  Text(
                    text,
                    style: selected
                      ? bottomNavTheme.selectedLabelStyle
                      : bottomNavTheme.unselectedLabelStyle
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
