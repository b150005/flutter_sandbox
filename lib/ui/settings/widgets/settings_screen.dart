part of '../../../core/routing/router.dart';

class SettingsScreenRoute extends GoRouteData with _$SettingsScreenRoute {
  static const path = '/settings';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Center(
    child: Column(
      children: [
        TextButton(onPressed: () => {}, child: const Text('go')),
        TextButton(
          onPressed: () => ScaffoldMessenger.showSnackBar('Hello, world!'),
          child: const Text('Show SnackBar'),
        ),
      ],
    ),
  );
}
