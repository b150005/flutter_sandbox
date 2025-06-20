part of '../../../../../core/routing/router.dart';

class LoginScreenRoute extends GoRouteData with _$LoginScreenRoute {
  static const path = 'login';
  static const absolutePath = '/sample/firebase/login';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginScreen();
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const Placeholder();
}
