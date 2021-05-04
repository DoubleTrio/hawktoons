// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:history_app/blocs/blocs.dart';
// import 'package:history_app/daily_cartoon/daily_cartoon.dart';
// import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
// import 'package:history_app/widgets/widgets.dart';
// import 'package:political_cartoon_repository/political_cartoon_repository.dart';
//
// class HomeScreen extends StatefulWidget {
//   static Route<AppTab> route() {
//     final _firebaseCartoonRepo = FirestorePoliticalCartoonRepository();
//     return MaterialPageRoute(
//         builder: (_) => MultiBlocProvider(providers: [
//               BlocProvider<TabBloc>(
//                 create: (_) => TabBloc(),
//               ),
//               BlocProvider<UnitCubit>(create: (_) => UnitCubit()),
//               BlocProvider<SortByCubit>(create: (_) => SortByCubit()),
//               BlocProvider<DailyCartoonBloc>(
//                   create: (_) => DailyCartoonBloc(
//                       dailyCartoonRepository: _firebaseCartoonRepo)
//                     ..add(LoadDailyCartoon())),
//               BlocProvider<AllCartoonsBloc>(create: (context) {
//                 final sortByMode = BlocProvider.of<SortByCubit>(context).state;
//                 return AllCartoonsBloc(cartoonRepository: _firebaseCartoonRepo)
//                   ..add(LoadAllCartoons(sortByMode));
//               }),
//               BlocProvider(create: (context) {
//                 final _allCartoonsBloc =
//                     BlocProvider.of<AllCartoonsBloc>(context);
//                 return FilteredCartoonsBloc(allCartoonsBloc: _allCartoonsBloc);
//               }),
//             ], child: HomeScreen()));
//   }
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final pages = [DailyCartoonScreen(), FilteredCartoonsPage()];
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TabBloc, AppTab>(
//       builder: (context, activeTab) {
//         final _pageController = PageController(initialPage: activeTab.index);
//         return Scaffold(
//             floatingActionButton: ThemeFloatingActionButton(),
//             bottomNavigationBar: TabSelector(
//                 activeTab: activeTab,
//                 onTabSelected: (tab) => {
//                       BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
//                       _pageController.jumpToPage(tab.index)
//                     }),
//             body: PageView(
//               physics: const NeverScrollaableScrollPhysics(),
//               onPageChanged: (index) => BlocProvider.of<TabBloc>(context)
//                   .add(UpdateTab(AppTab.values[index])),
//               controller: _pageController,
//               children: pages,
//             ));
//       },
//     );
//   }
// }
