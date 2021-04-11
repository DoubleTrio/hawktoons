import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/tab/tab.dart';
// import 'package:history_app/test_page.dart';
import 'package:history_app/theme/theme.dart';
import 'package:history_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = [DailyCartoonPage(), AllCartoonsPage()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        final _pageController = PageController(initialPage: activeTab.index);
        return Scaffold(
            appBar: AppBar(
              title: Text(activeTab == AppTab.daily ? 'Daily' : 'All'),
              actions: [
                if (activeTab == AppTab.daily)
                  IconButton(
                      icon: const Icon(Icons.filter_list), onPressed: () {})
              ],
            ),
            floatingActionButton: ThemeFloatingActionButton(),
            bottomNavigationBar: TabSelector(
                activeTab: activeTab,
                onTabSelected: (tab) => {
                      BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
                      _pageController.jumpToPage(tab.index)
                    }),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => BlocProvider.of<TabBloc>(context)
                  .add(UpdateTab(AppTab.values[index])),
              controller: _pageController,
              children: pages,
            ));
      },
    );
  }
}
