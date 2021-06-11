import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/tab/tab.dart';

class TabSelector extends StatefulWidget {
  TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabChanged,
  }) : super(key: key);

  final AppTab activeTab;
  final ValueChanged<AppTab> onTabChanged;

  @override
  State<TabSelector> createState() => _TabSelectorState();
}

class _TabSelectorState extends State<TabSelector>
    with SingleTickerProviderStateMixin {
  final int totalTabs = AppTab.values.length;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / totalTabs;
    final curve = Curves.easeIn;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final slide = (screenWidth * controller.value) / 1.5;
            return Transform(
              transform: Matrix4.identity()..translate(slide),
              child: child,
            );
          },
          child: Container(
            width: tabWidth,
            color: Theme.of(context).colorScheme.primary,
            height: 3
          )
        ),
        Row(
          children: [
            CustomBottomTabItem(
              key: const Key('TabSelector_LatestTab'),
              icon: const Icon(Icons.article_outlined),
              width: tabWidth,
              onTap: () {
                widget.onTabChanged(AppTab.latest);
                controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 400),
                  curve: curve,
                );
              },
              selected: AppTab.latest == widget.activeTab,
              text: l10n.appTabLatestText,
              label: l10n.appTabLatestLabel,
              hint: l10n.appTabLatestHint,
              sortKey: const OrdinalSortKey(0),
            ),
            CustomBottomTabItem(
              key: const Key('TabSelector_AllTab'),
              icon: const Icon(Icons.list),
              width: tabWidth,
              onTap: () { 
                widget.onTabChanged(AppTab.all);
                controller.animateTo(
                  0.5,
                  duration: const Duration(milliseconds: 400),
                  curve: curve,
                );
              },
              selected: AppTab.all == widget.activeTab,
              text: l10n.appTabAllText,
              label: l10n.appTabAllLabel,
              hint: l10n.appTabAllHint,
              sortKey: const OrdinalSortKey(1),
            ),
            CustomBottomTabItem(
              key: const Key('TabSelector_SettingsTab'),
              icon: const Icon(Icons.settings_outlined),
              width: tabWidth,
              onTap: () {
                widget.onTabChanged(AppTab.settings);
                controller.animateTo(
                  1,
                  duration: const Duration(milliseconds: 400),
                  curve: curve,
                );
              },
              selected: AppTab.settings == widget.activeTab,
              text: l10n.appTabSettingsText,
              label: l10n.appTabSettingsLabel,
              hint: l10n.appTabSettingsHint,
              sortKey: const OrdinalSortKey(2),
            ),
          ]
        ),
      ],
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
