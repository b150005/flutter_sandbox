part of '../../../../../core/routing/router.dart';

class ForgotPasswordScreenRoute extends GoRouteData
    with $ForgotPasswordScreenRoute {
  static const path = '/forgot-password';
  static const absolutePath = '/sample/firebase/forgot-password';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ForgotPasswordScreen();
}

@immutable
class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);
    final authRepository = ref.watch(authRepositoryProvider.notifier);

    return ScrollableContainer(
      child: Column(
        spacing: Spacing.xxxl.dp,
        children: [
          Text(l10n.enterEmailForPasswordReset),
          EmailInputForm(
            onSubmit: (email) =>
                authRepository.sendPasswordResetEmail(email: email),
            onSuccess: (_) => context.go(EmailSentScreenRoute.absolutePath),
          ),
        ],
      ),
    );
  }
}
