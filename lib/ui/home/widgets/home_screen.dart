part of '../../../core/routing/router.dart';

class HomeScreenRoute extends GoRouteData with $HomeScreenRoute {
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

@immutable
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Center(
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
