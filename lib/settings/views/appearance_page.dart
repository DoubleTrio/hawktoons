import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/widgets/widgets.dart';

class ThemePage extends Page<void> {
  const ThemePage() : super(key: const ValueKey('ThemePage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
        const ThemeView(),
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = const Offset(1.0, 0.0);
        final end = Offset.zero;
        final curve = Curves.easeInCubic;
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

class ThemeView extends StatelessWidget {
  const ThemeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void _navigateBack() {
      context.read<SettingsScreenCubit>().deselectScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: ScaffoldTitle(title: l10n.appearancePageAppearanceText),
        centerTitle: true,
        leading: CustomIconButton(
          onPressed: _navigateBack,
          icon: const Icon(Icons.arrow_back),
          label: 'Back button',
          hint: 'Tap to navigate back to the main settings page',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            PaddedSectionHeader(header: l10n.themePagePrimaryColorHeaderText),
            const CustomTile(
              child: PrimaryColorPicker()
            ),
            const SizedBox(height: 16),
            PaddedSectionHeader(header: l10n.themePageThemeModeHeaderText),
            const ThemeModePicker(),
            const SizedBox(height: 16),
            PaddedSectionHeader(header: l10n.themePageImageViewTypeHeaderText),
            const CartoonViewPicker(),
          ],
        )
      ),
    );
  }
}

class PrimaryColorPicker extends StatelessWidget {
  const PrimaryColorPicker({Key? key}) : super(key: key);

  final primaryColors = PrimaryColor.values;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeMode = context.select<AppearancesCubit, ThemeMode>(
      (bloc) => bloc.state.themeMode
    );

    final currentPrimaryColor = context.select<AppearancesCubit, PrimaryColor>(
      (bloc) => bloc.state.primaryColor
    );

    void _changePrimaryColor(PrimaryColor primary) {
      context.read<AppearancesCubit>().setColor(primary);
    }

    return Container(
      color: Theme.of(context).colorScheme.background,
      height: 90,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: primaryColors.length,
        itemBuilder: (_, index) {
          final primary = primaryColors[index];
          return PrimaryColorItem(
            key: Key('PrimaryColorItem_${primary.index}'),
            color: themeMode == ThemeMode.light
              ? primary.lightColor!
              : primary.darkColor!,
            colorName: primary.getColorName(l10n)!,
            selected: primary == currentPrimaryColor,
            onPrimaryChange: () => _changePrimaryColor(primary)
          );
        },
      ),
    );
  }
}

class ThemeModePicker extends StatelessWidget {
  const ThemeModePicker({Key? key}) : super(key: key);

  final themeModes = ThemeMode.values;

  @override
  Widget build(BuildContext context) {
    final n = themeModes.length;
    final l10n = context.l10n;
    final selectedThemeMode = context.select<AppearancesCubit, ThemeMode>(
      (bloc) => bloc.state.themeMode
    );

    final theme = Theme.of(context);

    void _setTheme(ThemeMode themeMode) {
      context.read<AppearancesCubit>().setTheme(themeMode);
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: n,
      itemBuilder: (_, index) {
        final themeMode = themeModes[index];
        return TappableTile(
          key: Key('ThemeModeTile_${themeMode.index}'),
          onTap: () => _setTheme(themeMode),
          isLast: index == n - 1,
          selected: themeMode == selectedThemeMode,
          child: Text(
            themeMode.getDescription(l10n)!,
            style: theme.textTheme.bodyText1
          ),
        );
      }
    );
  }
}

class CartoonViewPicker extends StatelessWidget {
  const CartoonViewPicker({Key? key}) : super(key: key);

  final cartoonViews = CartoonView.values;

  @override
  Widget build(BuildContext context) {
    final n = cartoonViews.length;
    final l10n = context.l10n;
    final selectedCartoonView = context.select<AppearancesCubit, CartoonView>(
      (bloc) => bloc.state.cartoonView
    );
    final theme = Theme.of(context);

    void _setCartoonView(CartoonView view) {
      context.read<AppearancesCubit>().setCartoonView(view);
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: n,
      itemBuilder: (_, index) {
        final cartoonView = cartoonViews[index];
        return TappableTile(
          key: Key('CartoonViewTile_${cartoonView.index}'),
          onTap: () => _setCartoonView(cartoonView),
          leading: cartoonView.getIcon(
            theme.colorScheme.onBackground.withOpacity(0.5)
          ),
          isLast: index == n - 1,
          selected: cartoonView == selectedCartoonView,
          child: Text(
            cartoonView.getViewType(l10n)!,
            style: theme.textTheme.bodyText1
          ),
        );
      }
    );
  }
}
