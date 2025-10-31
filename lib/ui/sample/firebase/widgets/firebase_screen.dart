part of '../../../../core/routing/router.dart';

class FirebaseScreenRoute extends GoRouteData with $FirebaseScreenRoute {
  static const path = '/firebase';
  static const absolutePath = '/sample/firebase';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FirebaseScreen();
}

@immutable
class FirebaseScreen extends HookConsumerWidget {
  const FirebaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    useAppBar(
      ref,
      path: FirebaseScreenRoute.absolutePath,
      state: AppBarState(title: Text(l10n.firebase)),
    );

    final contents = ref.watch(firebaseContentsProvider);

    return GridView.extent(
      maxCrossAxisExtent: GridDimensions.maxCrossAxisExtent,
      children: contents
          .map((content) => ContentCard(content: content))
          .toList(),
    );
  }
}
