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

    final contents = ref.watch(firebaseContentsProvider);

    return AppBarScope(
      state: AppBarState(title: Text(l10n.firebase)),
      child: GridView.extent(
        maxCrossAxisExtent: GridDimensions.maxCrossAxisExtent,
        children: contents
            .map((content) => ContentCard(content: content))
            .toList(),
      ),
    );
  }
}
