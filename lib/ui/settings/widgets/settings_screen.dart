part of '../../../core/routing/router.dart';

class SettingsScreenRoute extends GoRouteData with $SettingsScreenRoute {
  static const path = '/settings';
  static const absolutePath = '/settings';

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

    return AppBarScope(
      state: AppBarState(title: Text(l10n.settings)),
      child: ScrollableContainer(
        child: Column(
          children: [
            TextButton(onPressed: () => {}, child: const Text('go')),
            TextButton(
              onPressed: () => AppMessenger.showSnackBar('Hello, world!'),
              child: const Text('Show SnackBar'),
            ),
          ],
        ),
      ),
    );
  }
}
