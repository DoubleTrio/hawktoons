import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:hawktoons/home/flow/home_flow.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class DrawerStackPage extends Page<void> {
  const DrawerStackPage() : super(key: const ValueKey('DrawerStackPage'));

  @override
  Route createRoute(BuildContext context) {
    final _firebaseCartoonRepo =
      context.read<FirestorePoliticalCartoonRepository>();
    final _allCartoonsBloc = AllCartoonsBloc(
      cartoonRepository: _firebaseCartoonRepo
    );
    final _appDrawerCubit = AppDrawerCubit();
    final _dailyCartoonBloc = DailyCartoonBloc(
      dailyCartoonRepository: _firebaseCartoonRepo
    );
    final _imageTypeCubit = ImageTypeCubit();
    final _tabBloc = TabBloc();
    final _tagCubit = TagCubit();
    final _scrollHeaderCubit = ScrollHeaderCubit();
    final _selectCartoonCubit = SelectCartoonCubit();
    final _showBottomSheetCubit = ShowBottomSheetCubit();
    final _sortByCubit = SortByCubit();

    final _sortByMode = _sortByCubit.state;
    final _imageType = _imageTypeCubit.state;
    final _tag = _tagCubit.state;

    final filters = CartoonFilters(
        sortByMode: _sortByMode,
        imageType: _imageType,
        tag: _tag
    );

    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (_, __, ___) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _allCartoonsBloc
            ..add(LoadCartoons(filters))),
          BlocProvider.value(value: _appDrawerCubit),
          BlocProvider.value(value: _dailyCartoonBloc
            ..add(const LoadDailyCartoon())),
          BlocProvider.value(value: _imageTypeCubit),
          BlocProvider.value(value: _scrollHeaderCubit),
          BlocProvider.value(value: _selectCartoonCubit),
          BlocProvider.value(value: _showBottomSheetCubit),
          BlocProvider.value(value: _sortByCubit),
          BlocProvider.value(value: _tabBloc),
          BlocProvider.value(value: _tagCubit),
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
  final double maxSlide = 300.0;

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
      final delta = details.primaryDelta! / maxSlide;
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
    return BlocListener<AppDrawerCubit, bool>(
      listener: (context, shouldOpenDrawer) {
        if (shouldOpenDrawer) openDrawer();
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
            final slide = maxSlide * value;
            return Stack(
              children: [
                const AppDrawerPage(),
                Transform(
                  transform: Matrix4.identity()..translate(slide),
                  child: child
                ),
              ],
            );
          },
          child: const HomeFlow()
        ),
      ),
    );
  }
}
