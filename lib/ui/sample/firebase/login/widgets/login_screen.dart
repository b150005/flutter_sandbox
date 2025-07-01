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
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Spacing.sm.dp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Spacing.xxxl.dp,
          children: [
            SizedBox(
              width: IconSize.xxxl.dp,
              child: Image.asset(Assets.firebase.path),
            ),
            const LoginForm(),
            OutlinedButton(
              key: WidgetKeys.createNewAccount,
              onPressed: () {},
              style: OutlinedButton.styleFrom(fixedSize: ButtonSize.md.size),
              child: Text(l10n.createNewAccount),
            ),
          ],
        ),
      ),
    );
  }
}
