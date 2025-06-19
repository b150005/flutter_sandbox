part of '../../../../core/routing/router.dart';

class FirebaseScreenRoute extends GoRouteData with _$FirebaseScreenRoute {
  static const path = 'firebase';
  static const absolutePath = '/sample/firebase';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FirebaseScreen();
}

class FirebaseScreen extends ConsumerWidget {
  const FirebaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      const Scaffold(body: SafeArea(child: Placeholder()));
}
