part of '../../../../../core/routing/router.dart';

class SignInScreenRoute extends GoRouteData with $SignInScreenRoute {
  static const path = '/login';
  static const absolutePath = '/sample/firebase/login';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SignInScreen();
}

@immutable
class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return ScrollableContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Spacing.xxxl.dp,
        children: [
          SizedBox(
            width: IconSize.xxxl.dp,
            child: Image.asset(Assets.firebase.path),
          ),
          const SignInForm(),
          OutlinedButton(
            key: WidgetKeys.signUp,
            onPressed: () => context.go(SignUpScreenRoute.absolutePath),
            style: OutlinedButton.styleFrom(minimumSize: ButtonSize.lg.size),
            child: Text(l10n.signUp),
          ),
        ],
      ),
    );
  }
}
