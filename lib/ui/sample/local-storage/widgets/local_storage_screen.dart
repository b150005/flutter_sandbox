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
class LocalStorageScreen extends HookConsumerWidget {
  const LocalStorageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    useAppBar(
      ref,
      path: LocalStorageScreenRoute.absolutePath,
      state: AppBarState(title: Text(l10n.localStorage)),
    );

    return const Placeholder();
  }
}
