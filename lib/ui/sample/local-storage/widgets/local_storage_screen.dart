part of '../../../../core/routing/router.dart';

class LocalStorageScreenRoute extends GoRouteData
    with $LocalStorageScreenRoute {
  static const path = '/local-storage';
  static const absolutePath = '/sample/local-storage';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LocalStorageScreen();
}

@immutable
class LocalStorageScreen extends ConsumerWidget {
  const LocalStorageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const Placeholder();
}
