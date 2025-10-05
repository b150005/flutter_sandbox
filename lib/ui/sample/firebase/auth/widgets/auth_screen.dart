part of '../../../../../core/routing/router.dart';

class AuthScreenRoute extends GoRouteData with $AuthScreenRoute {
  static const path = '/auth';
  static const absolutePath = '/sample/firebase/auth';

  @override
  Widget build(BuildContext context, GoRouterState state) => const AuthScreen();
}

@immutable
class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final currentUser = firebaseAuth.currentUser;

    return ScrollableContainer(
      child: Column(
        spacing: Spacing.sm.dp,
        children: [Text(currentUser?.uid ?? 'null')],
      ),
    );
  }
}
