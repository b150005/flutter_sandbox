part of '../../../../../core/routing/router.dart';

class AuthScreenRoute extends GoRouteData with $AuthScreenRoute {
  static const path = '/auth';
  static const absolutePath = '/sample/firebase/auth';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SelectionArea(child: AuthScreen());
}

@immutable
class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ScrollableContainer(
    child: Column(
      spacing: Spacing.sm.dp,
      children: const [
        UserProfileCard(),
        UserAuthDetailCard(),
      ],
    ),
  );
}
