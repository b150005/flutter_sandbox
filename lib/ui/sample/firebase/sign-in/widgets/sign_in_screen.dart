part of '../../../../../core/routing/router.dart';

class SignInScreenRoute extends GoRouteData with $SignInScreenRoute {
  static const path = '/sign-in';
  static const absolutePath = '/sample/firebase/sign-in';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SignInScreen();
}

@immutable
class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return AppBarScope(
      state: AppBarState(title: Text(l10n.firebaseSignIn)),
      child: ScrollableContainer(
        child: Column(
          mainAxisAlignment: .center,
          spacing: Spacing.xxxl.dp,
          children: [
            SizedBox(
              width: IconSize.xxxl.dp,
              child: Image.asset(Assets.firebase.path),
            ),
            const SignInForm(),
            OutlinedButton(
              key: WidgetKeys.signUp,
              onPressed: () => SignUpScreenRoute().go(context),
              style: OutlinedButton.styleFrom(minimumSize: ButtonSize.lg.size),
              child: Text(l10n.signUp),
            ),
          ],
        ),
      ),
    );
  }
}
