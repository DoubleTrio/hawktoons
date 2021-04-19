import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:history_app/app/auth_page.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/filtered_cartoons/view/details_page.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:history_app/theme_data.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseUserRepo = FirebaseUserRepository();
    final _firebaseCartoonRepo = FirestorePoliticalCartoonRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<UnitCubit>(create: (_) => UnitCubit()),
        BlocProvider<SortByCubit>(create: (_) => SortByCubit()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(userRepository: _firebaseUserRepo)
              ..add(StartApp())),
        BlocProvider<TabBloc>(
          create: (_) => TabBloc(),
        ),
        BlocProvider<DailyCartoonBloc>(
            create: (_) =>
                DailyCartoonBloc(dailyCartoonRepository: _firebaseCartoonRepo)
                  ..add(LoadDailyCartoon())),
        BlocProvider<AllCartoonsBloc>(create: (context) {
          final sortByMode = BlocProvider.of<SortByCubit>(context).state;
          return AllCartoonsBloc(cartoonRepository: _firebaseCartoonRepo)
            ..add(LoadAllCartoons(sortByMode));
        }),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = context.select((ThemeCubit cubit) => cubit.state);

    return MaterialApp(
      themeMode: themeMode,
      theme: lightThemeData,
      darkTheme: ThemeData(
          accentColor: Colors.lightGreenAccent,
          appBarTheme: const AppBarTheme(color: Colors.lightGreenAccent)),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => AuthPage());
        }
        if (settings.name == AppTab.daily.routeName) {
          return MaterialPageRoute(builder: (context) => DailyCartoonPage());
        } else if (settings.name!.startsWith(AppTab.all.routeName)) {
          var uri = Uri.parse(settings.name!);
          if (uri.pathSegments.length == 2) {
            // var id = uri.pathSegments[1];
            var cartoon = settings.arguments as PoliticalCartoon;
            return MaterialPageRoute(
                builder: (context) => DetailsPage(
                      cartoon: cartoon,
                    ));
          } else {
            return MaterialPageRoute(builder: (context) {
              final _allCartoonsBloc =
                  BlocProvider.of<AllCartoonsBloc>(context);
              final _unit = context.read<UnitCubit>().state;
              return BlocProvider(
                create: (context) =>
                    FilteredCartoonsBloc(allCartoonsBloc: _allCartoonsBloc)
                      ..add(UpdateFilter(_unit)),
                child: FilteredCartoonsPage(),
              );
            });
          }
        }

        // // Handle '/details/:id'
        // var uri = Uri.parse(settings.name!);
        // if (uri.pathSegments.length == 2 &&
        //     uri.pathSegments.first == 'details') {
        //   var id = uri.pathSegments[1];
        //   return MaterialPageRoute(
        //       builder: (context) => FilteredCartoonsPage());
        // }
      },
      initialRoute: '/',
    );
  }
}
