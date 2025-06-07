part of '../../../core/routing/router.dart';

class SampleScreenRoute extends GoRouteData with _$SampleScreenRoute {
  static const path = '/sample';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SampleScreen();
}

class SampleScreen extends ConsumerWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    body: SafeArea(
      child: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () => FirebaseScreenRoute().go(context),
              child: const Text('go'),
            ),
            TextButton(
              onPressed: () => ScaffoldMessenger.showSnackBar('Hello, world!'),
              child: const Text('Show SnackBar'),
            ),
          ],
        ),
      ),
    ),
  );
}
