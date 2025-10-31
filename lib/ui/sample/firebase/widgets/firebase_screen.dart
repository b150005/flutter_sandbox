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
    final isAtFirebaseScreen = context.isAt(FirebaseScreenRoute.absolutePath);

    final l10n = ref.watch(appLocalizationsProvider);

    useEffect(() {
      if (isAtFirebaseScreen) {
        Future.microtask(
          () => ref
              .read(appBarStateProvider.notifier)
              .update(
                AppBarState(
                  title: Text(l10n.firebase),
                ),
              ),
        );
      }

      return null;
    }, [isAtFirebaseScreen]);

    final contents = ref.watch(firebaseContentsProvider);

    return GridView.extent(
      maxCrossAxisExtent: GridDimensions.maxCrossAxisExtent,
      children: contents
          .map((content) => ContentCard(content: content))
          .toList(),
    );
  }
}
