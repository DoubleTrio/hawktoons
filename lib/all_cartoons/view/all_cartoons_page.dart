import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/all_cartoons/blocs/blocs.dart';
import 'package:history_app/all_cartoons/widgets/widgets.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/widgets/custom_icon_button.dart';
import 'package:history_app/widgets/loading_indicator.dart';
import 'package:history_app/widgets/scaffold_title.dart';

class AllCartoonsPage extends Page<void> {
  AllCartoonsPage() : super(key: const ValueKey('AllCartoonsPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (_, __, ___) =>
        const AllCartoonsView(),
      transitionDuration: const Duration(milliseconds: 800),
    );
  }
}

class AllCartoonsView extends StatelessWidget {
  const AllCartoonsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final _shouldDisplayTitle = context.watch<ScrollHeaderCubit>().state;
    void _logout() {
      context.read<AuthenticationBloc>().add(const Logout());
    }
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          key: const Key('AllCartoonsPage_LogoutButton'),
          icon: const Icon(Icons.exit_to_app_rounded),
          onPressed: _logout,
        ),
        title: AnimatedOpacity(
          opacity: _shouldDisplayTitle ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 800),
          child: const ScaffoldTitle(
            title: 'All Images',
          ),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            key: const Key('AllCartoonsPage_FilterButton'),
            icon: const Icon(Icons.filter_list),
            onPressed: () => context.read<ShowBottomSheetCubit>().openSheet(),
          )
        ]
      ),
      body: Column(
        children: [
          BlocConsumer<AllCartoonsBloc, AllCartoonsState>(
            listenWhen: (prev, curr) => prev.filters != curr.filters,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text('Filter applied!'),
                ),
              );
            },
            builder: (context, state) {
              if (state.status == CartoonStatus.initial) {
                return Column(
                  key: const Key('AllCartoonsPage_AllCartoonsLoading'),
                  children: [
                    const SizedBox(height: 24),
                    const LoadingIndicator(),
                  ],
                );
              }
              if (state.status == CartoonStatus.success ||
                  state.status == CartoonStatus.loading) {
                return StaggeredCartoonGrid(
                  cartoons: state.cartoons,
                  key: const Key('AllCartoonsPage_AllCartoonsLoaded'),
                );
              }
              return SizedBox(
                height: 30,
                width: double.infinity,
                child: Text(
                  'An error has occurred while loading for images',
                  key: const Key('AllCartoonsPage_AllCartoonsFailed'),
                  style: TextStyle(
                    color: colorScheme.error,
                    fontSize: 14
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
