import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/tab/tab.dart';
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
            appBar: AppBar(title: const Text('Cartoons')),
            floatingActionButton: ThemeFloatingActionButton(),
            bottomNavigationBar: TabSelector(
                activeTab: activeTab,
                onTabSelected: (tab) => {
                      BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
                      _pageController.jumpToPage(tab.index)
                    }),
            body: PageView(
              onPageChanged: (index) => BlocProvider.of<TabBloc>(context)
                  .add(UpdateTab(AppTab.values[index])),
              controller: _pageController,
              children: pages,
            ));
      },
    );
  }
}
