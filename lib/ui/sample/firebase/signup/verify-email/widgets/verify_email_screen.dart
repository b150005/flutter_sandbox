part of '../../../../../../core/routing/router.dart';

class VerifyEmailScreenRoute extends GoRouteData with _$VerifyEmailScreenRoute {
  static const path = '/verify-email';
  static const absolutePath = '/sample/firebase/signup/verify-email';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      VerifyEmailScreen(emailLink: state.uri);
}

class VerifyEmailScreen extends HookConsumerWidget {
  const VerifyEmailScreen({super.key, required this.emailLink});

  final Uri emailLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenState = useState<_EmailVerificationState>(
      _EmailVerificationState.loading,
    );

    final errorMessage = useState<String?>(null);

    final email = useState<String?>(null);

    final authRepository = ref.watch(authRepositoryProvider.notifier);
    final l10n = ref.watch(appLocalizationsProvider);

    useEffect(() {
      authRepository
          .signInWithEmailLink(emailLink: emailLink.toString())
          .then(
            (result) => result.when(
              (credential) {
                email.value = credential.user?.email;
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
      _EmailVerificationState.loading => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      _EmailVerificationState.success => ScrollableContainer(
        child: Column(
          spacing: Spacing.xxxl.dp,
          children: [
            Icon(Icons.check, size: IconSize.lg.iconSize),
            Text(l10n.signInWithEmailLinkSuccessfully),
            if (email.value != null) PasswordSetupForm(email: email.value!),
          ],
        ),
      ),
      _EmailVerificationState.invalidLink => ScrollableContainer(
        child: Column(
          spacing: Spacing.xxxl.dp,
          children: [
            Icon(Icons.error_outlined, size: IconSize.lg.iconSize),
            Text(errorMessage.value!),
          ],
        ),
      ),
      _EmailVerificationState.emailNotFound => ScrollableContainer(
        child: Column(
          spacing: Spacing.xxxl.dp,
          children: [
            Icon(Icons.warning_amber_outlined, size: IconSize.lg.iconSize),
            Text(errorMessage.value!),
            // TODO(b150005): メールアドレスを検証する Form の作成
          ],
        ),
      ),
      _EmailVerificationState.serviceUnavailable => ScrollableContainer(
        child: Column(
          spacing: Spacing.xxxl.dp,
          children: const [Placeholder()],
        ),
      ),
      _EmailVerificationState.unknown => ScrollableContainer(
        child: Column(
          spacing: Spacing.xxxl.dp,
          children: const [Placeholder()],
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
