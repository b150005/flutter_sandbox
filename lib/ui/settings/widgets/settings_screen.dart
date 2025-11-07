part of '../../../core/routing/router.dart';

class SettingsScreenRoute extends GoRouteData with $SettingsScreenRoute {
  static const path = '/settings';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

@immutable
class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    useAppBar(
      ref,
      path: SettingsScreenRoute.path,
      state: AppBarState(title: Text(l10n.settings)),
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
