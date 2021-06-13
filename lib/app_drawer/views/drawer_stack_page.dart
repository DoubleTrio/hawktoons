import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:hawktoons/latest_cartoon/bloc/latest_cartoon.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:hawktoons/utils/constants.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class DrawerStackPage extends Page<void> {
  const DrawerStackPage() : super(key: const ValueKey('DrawerStackPage'));

  @override
  Route createRoute(BuildContext context) {
    final _firebaseCartoonRepo =
      context.read<FirestorePoliticalCartoonRepository>();
    final _appearancesCubit = context.read<AppearancesCubit>();

    final _allCartoonsBloc = AllCartoonsBloc(
      cartoonRepository: _firebaseCartoonRepo,
      appearancesCubit: _appearancesCubit,
    );

    final _allCartoonsPageBloc = AllCartoonsPageCubit();

    final _appDrawerCubit = AppDrawerCubit();
    final _filterSheetCubit = FilterSheetCubit();

    final _latestCartoonBloc = LatestCartoonBloc(
      cartoonRepository: _firebaseCartoonRepo
    );

    final _tabBloc = TabBloc();
    final _settingsPageCubit = SettingsScreenCubit();

    final filters = _filterSheetCubit.state;
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (_, __, ___) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _allCartoonsBloc
            ..add(LoadCartoons(filters))
          ),
          BlocProvider.value(value: _allCartoonsPageBloc),
          BlocProvider.value(value: _appDrawerCubit),
          BlocProvider.value(value: _filterSheetCubit),
          BlocProvider.value(value: _latestCartoonBloc
            ..add(const LoadLatestCartoon())
          ),
          BlocProvider.value(value: _settingsPageCubit),
          BlocProvider.value(value: _tabBloc),
        ],
        child: const DrawerStackView(),
      ),
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = const Offset(0.0, 1.0);
        final end = Offset.zero;
        final curve = Curves.ease;
        final tween = Tween(begin: begin, end: end)
          ..chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class DrawerStackView extends StatefulWidget {
  const DrawerStackView({Key? key}) : super(key: key);

  @override
  State<DrawerStackView> createState() => _DrawerStackViewState();
}

class _DrawerStackViewState extends State<DrawerStackView>
    with SingleTickerProviderStateMixin {

  bool _canBeDragged = false;
  final double opacityPercentage = 0.20;

  late AnimationController animationController;

  @override
  void initState() {
    final appDrawerCubit = context.read<AppDrawerCubit>();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        appDrawerCubit.openDrawer();
      } else if (status == AnimationStatus.dismissed) {
        appDrawerCubit.closeDrawer();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  bool isDrawerClosed() {
    return animationController.isDismissed;
  }

  void openDrawer() {
    if (isDrawerClosed()) {
      animationController.forward();
    }
  }

  void closeDrawer() {
    if (!isDrawerClosed()) {
      animationController.reverse();
    }
  }

  void _onDragStart(DragStartDetails details) {
    final isDragOpenFromLeft = animationController.isDismissed;
    final isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      final delta = details.primaryDelta! / drawerSwipeDistance;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    final _kMinFlingVelocity = 365.0;
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }

    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      final visualVelocity = details.velocity.pixelsPerSecond.dx /
        MediaQuery.of(context).size.width;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDrawerOpen = context.watch<AppDrawerCubit>().state;
    return BlocListener<AppDrawerCubit, bool>(
      listener: (context, shouldOpenDrawer) {
        shouldOpenDrawer ? openDrawer() : closeDrawer();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        onTap: closeDrawer,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            final value = animationController.value;
            final slide = drawerSwipeDistance * value;
            final appDrawerOpacity =  opacityPercentage * (1 - value);
            final homeScreenOpacity = opacityPercentage * 0.20;
            return Stack(
              children: [
                AppDrawerView(backgroundOpacity: appDrawerOpacity),
                Transform(
                  transform: Matrix4.identity()..translate(slide),
                  child: Stack(
                    children: [
                      child!,
                      IgnorePointer(
                        ignoring: true,
                        child: Container(
                          color: Colors.black.withOpacity(homeScreenOpacity),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          child: IgnorePointer(
            ignoring: isDrawerOpen,
            child: const TabFlow()
          )
        ),
      ),
    );
  }
}
