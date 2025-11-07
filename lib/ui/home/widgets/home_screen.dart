part of '../../../core/routing/router.dart';

class HomeScreenRoute extends GoRouteData with $HomeScreenRoute {
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

@immutable
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    useAppBar(
      ref,
      path: HomeScreenRoute.path,
      state: AppBarState(title: Text(l10n.home)),
    );

    return ScrollableContainer(
      child: Column(
        children: [
          TextButton(onPressed: () => {}, child: const Text('go')),
          TextButton(
            onPressed: () => AppMessenger.showSnackBar('Hello, world!'),
            child: const Text('Show SnackBar'),
          ),
        ],
      ),
    );
  }
}
