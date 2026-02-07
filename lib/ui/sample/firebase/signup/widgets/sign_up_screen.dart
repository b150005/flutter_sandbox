part of '../../../../../core/routing/router.dart';

class SignUpScreenRoute extends GoRouteData with $SignUpScreenRoute {
  static const path = '/signup';
  static const absolutePath = '/sample/firebase/signup';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SignUpScreen();
}

@immutable
class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return AppBarScope(
      state: AppBarState(title: Text(l10n.firebaseSignUp)),
      child: ScrollableContainer(
        child: Column(
          spacing: Spacing.md.dp,
          children: [
            Text(
              l10n.signUp,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge,
            ),
            Text(l10n.signUpDescription),
            const SignUpForm(),
          ],
        ),
      ),
    );
  }
}
