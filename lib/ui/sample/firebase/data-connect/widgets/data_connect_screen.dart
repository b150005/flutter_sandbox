part of '../../../../../core/routing/router.dart';

class DataConnectScreenRoute extends GoRouteData with $DataConnectScreenRoute {
  static const path = '/data-connect';
  static const absolutePath = '/sample/firebase/data-connect';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DataConnectScreen();
}

@immutable
class DataConnectScreen extends HookConsumerWidget {
  const DataConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    useAppBar(
      ref,
      path: DataConnectScreenRoute.absolutePath,
      state: AppBarState(title: Text(l10n.firebaseDataConnect)),
    );

    return const ScrollableContainer(
      child: Column(
        children: [Placeholder()],
      ),
    );
  }
}
