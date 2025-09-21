part of '../../../../../core/routing/router.dart';

@Preview(name: 'Auth Screen')
Widget authScreen() => const ProviderScope(child: AuthScreen());

class AuthScreenRoute extends GoRouteData with $AuthScreenRoute {
  static const path = '/auth';
  static const absolutePath = '/sample/firebase/auth';

  @override
  Widget build(BuildContext context, GoRouterState state) => const AuthScreen();
}

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return const ScrollableContainer(
      child: Column(
        children: [Placeholder()],
      ),
    );
  }
}
