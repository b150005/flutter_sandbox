part of '../../../core/routing/router.dart';

class HomeScreenRoute extends GoRouteData with _$HomeScreenRoute {
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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
