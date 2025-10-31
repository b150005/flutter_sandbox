part of '../../../../../core/routing/router.dart';

class FirebaseAuthScreenRoute extends GoRouteData
    with $FirebaseAuthScreenRoute {
  static const path = '/auth';
  static const absolutePath = '/sample/firebase/auth';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SelectionArea(child: FirebaseAuthScreen());
}

@immutable
class FirebaseAuthScreen extends HookConsumerWidget {
  const FirebaseAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    useAppBar(
      ref,
      path: FirebaseAuthScreenRoute.absolutePath,
      state: AppBarState(title: Text(l10n.firebaseAuth)),
    );

    return ScrollableContainer(
      child: Column(
        spacing: Spacing.sm.dp,
        children: const [
          UserProfileCard(),
          UserAuthDetailCard(),
        ],
      ),
    );
  }
}
