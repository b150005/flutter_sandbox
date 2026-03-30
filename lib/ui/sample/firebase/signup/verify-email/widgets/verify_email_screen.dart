part of '../../../../../../core/routing/router.dart';

class VerifyEmailScreenRoute extends GoRouteData with $VerifyEmailScreenRoute {
  static const path = 'verify-email';
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
    final screenState = useState<_EmailVerificationState>(.loading);

    final errorMessage = useState<String?>(null);

    final authRepository = ref.watch(authRepositoryProvider.notifier);
    final l10n = ref.watch(appLocalizationsProvider);

    useEffect(() {
      authRepository
          .signInWithEmailLink(emailLink: emailLink)
          .then(
            (result) => result.when(
              (_) {
                screenState.value = .success;
              },
              (appException) {
                errorMessage.value = appException.message;

                screenState.value = switch (appException) {
                  BadRequest() => .invalidLink,
                  NotFound() => .emailNotFound,
                  ServiceUnavailable() => .serviceUnavailable,
                  _ => .unknown,
                };
              },
            ),
          );

      return null;
    }, []);

    return AppBarScope(
      state: AppBarState(title: Text(l10n.verifyEmail)),
      child: switch (screenState.value) {
        .loading => Center(
          child: context.loadingIndicator,
        ),
        .success => ScrollableContainer(
          child: Column(
            spacing: Spacing.xxxl.dp,
            children: [
              Callout(
                l10n.signInWithEmailLinkSuccessfully,
                type: .success,
              ),
              PasswordSetupForm(
                onSubmit: () async => FirebaseScreenRoute().go(context),
              ),
            ],
          ),
        ),
        .emailNotFound => ScrollableContainer(
          child: Column(
            spacing: Spacing.xxxl.dp,
            children: [
              Callout(
                errorMessage.value!,
                type: .warning,
                onDismiss: () => errorMessage.value = null,
              ),
              EmailInputForm(
                onSubmit: (email) => authRepository.signInWithEmailLink(
                  email: email,
                  emailLink: emailLink,
                ),
                onSuccess: (credential) {
                  screenState.value = .success;
                },
              ),
            ],
          ),
        ),
        .invalidLink || .serviceUnavailable || .unknown => ScrollableContainer(
          child: Callout(
            errorMessage.value!,
            type: .error,
          ),
        ),
      },
    );
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
