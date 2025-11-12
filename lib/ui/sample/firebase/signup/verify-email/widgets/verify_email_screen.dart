part of '../../../../../../core/routing/router.dart';

class VerifyEmailScreenRoute extends GoRouteData with $VerifyEmailScreenRoute {
  static const path = '/verify-email';
  static const absolutePath = '/sample/firebase/signup/verify-email';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      VerifyEmailScreen(emailLink: state.uri);
}

@immutable
class VerifyEmailScreen extends HookConsumerWidget {
  const VerifyEmailScreen({super.key, required this.emailLink});

  final Uri emailLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenState = useState<_EmailVerificationState>(
      _EmailVerificationState.loading,
    );

    final errorMessage = useState<String?>(null);

    final authRepository = ref.watch(authRepositoryProvider.notifier);
    final l10n = ref.watch(appLocalizationsProvider);

    useAppBar(
      ref,
      path: VerifyEmailScreenRoute.absolutePath,
      state: AppBarState(title: Text(l10n.verifyEmail)),
    );

    useEffect(() {
      authRepository
          .signInWithEmailLink(emailLink: emailLink)
          .then(
            (result) => result.when(
              (credential) {
                screenState.value = _EmailVerificationState.success;
              },
              (appException) {
                errorMessage.value = appException.message;

                screenState.value = switch (appException) {
                  BadRequest() => _EmailVerificationState.invalidLink,
                  NotFound() => _EmailVerificationState.emailNotFound,
                  ServiceUnavailable() =>
                    _EmailVerificationState.serviceUnavailable,
                  _ => _EmailVerificationState.unknown,
                };
              },
            ),
          );

      return null;
    }, []);

    return switch (screenState.value) {
      _EmailVerificationState.loading => Center(
        child: context.loadingIndicator,
      ),
      _EmailVerificationState.success => ScrollableContainer(
        child: Column(
          spacing: Spacing.xxxl.dp,
          children: [
            Callout(
              l10n.signInWithEmailLinkSuccessfully,
              type: CalloutType.success,
            ),
            const PasswordSetupForm(),
          ],
        ),
      ),
      _EmailVerificationState.emailNotFound => ScrollableContainer(
        child: Column(
          spacing: Spacing.xxxl.dp,
          children: [
            Callout(
              errorMessage.value!,
              type: CalloutType.warning,
              onDismiss: () => errorMessage.value = null,
            ),
            EmailInputForm(
              submitAction: (email) => authRepository.signInWithEmailLink(
                email: email,
                emailLink: emailLink,
              ),
              onSuccess: (credential) {
                screenState.value = _EmailVerificationState.success;
              },
            ),
          ],
        ),
      ),
      _EmailVerificationState.invalidLink ||
      _EmailVerificationState.serviceUnavailable ||
      _EmailVerificationState.unknown => ScrollableContainer(
        child: Callout(
          errorMessage.value!,
          type: CalloutType.error,
        ),
      ),
    };
  }
}

enum _EmailVerificationState {
  loading,
  success,
  invalidLink,
  emailNotFound,
  serviceUnavailable,
  unknown,
}
