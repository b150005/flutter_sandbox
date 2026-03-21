part of '../../../../../../core/routing/router.dart';

class OTPVerificationScreenRoute extends GoRouteData
    with $OTPVerificationScreenRoute {
  const OTPVerificationScreenRoute({
    required this.verificationId,
    this.forceResendingToken,
    required this.$extra,
  });

  static const path = 'otp';
  static const absolutePath = '/sample/firebase/auth/otp';

  final String verificationId;
  final int? forceResendingToken;
  final PhoneNumber $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => SelectionArea(
    child: OtpVerificationScreen(
      verificationId: verificationId,
      forceResendingToken: forceResendingToken,
      phoneNumber: $extra,
    ),
  );
}

@immutable
class OtpVerificationScreen extends HookConsumerWidget {
  const OtpVerificationScreen({
    super.key,
    required String verificationId,
    int? forceResendingToken,
    required this.phoneNumber,
  }) : _forceResendingToken = forceResendingToken,
       _verificationId = verificationId;

  final String _verificationId;
  final int? _forceResendingToken;

  final PhoneNumber phoneNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final errorMessage = useState<String?>(null);

    void showErrorMessage(AppException appException) {
      errorMessage.value = appException.message;
    }

    final (verificationIdRef, forceResendingTokenRef) = (
      useRef<String>(_verificationId),
      useRef<int?>(_forceResendingToken),
    );

    final authRepository = ref.watch(authRepositoryProvider.notifier);

    return AppBarScope(
      state: AppBarState(title: Text(l10n.otpVerification)),
      child: AuthStateBuilder(
        builder: (_) => ScrollableContainer(
          child: Column(
            spacing: Spacing.sm.dp,
            children: [
              if (errorMessage.value.isNotNullAndNotEmpty)
                Callout(
                  errorMessage.value!,
                  type: .error,
                ),
              OTPInputForm(
                length: 6,
                forceResendingToken: _forceResendingToken,
                onCompleted: (smsCode) async {
                  final result = await authRepository.updatePhoneNumber(
                    verificationId: verificationIdRef.value,
                    smsCode: smsCode,
                  );

                  result.when(
                    (_) {
                      context.rootNavigator.safePop();

                      AppMessenger.showMaterialBanner(
                        MaterialBanner(
                          content: Text(l10n.updatePhoneNumberSuccessfully),
                          leading: const Icon(Icons.phone_outlined),
                          actions: const [DismissMaterialBannerButton()],
                        ),
                      );
                    },
                    showErrorMessage,
                  );
                },
                onResend: () async {
                  final verificationResult = await authRepository
                      .verifyPhoneNumber(
                        countryCode: phoneNumber.countryCode!,
                        nationalNumber: phoneNumber.nationalNumber,
                        onPhoneNumberUpdated: (phoneNumberUpdateResult) =>
                            phoneNumberUpdateResult.when(
                              (_) {
                                context.rootNavigator.safePop();

                                AppMessenger.showMaterialBanner(
                                  MaterialBanner(
                                    content: Text(
                                      l10n.updatePhoneNumberSuccessfully,
                                    ),
                                    leading: const Icon(Icons.phone_outlined),
                                    actions: const [
                                      DismissMaterialBannerButton(),
                                    ],
                                  ),
                                );
                              },
                              showErrorMessage,
                            ),
                        onVerificationFailed: showErrorMessage,
                        onCodeSent: (verificationId, forceResendingToken) {
                          verificationIdRef.value = verificationId;
                          forceResendingTokenRef.value = forceResendingToken;
                        },
                        forceResendingToken: forceResendingTokenRef.value,
                      );

                  verificationResult.onError(showErrorMessage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
