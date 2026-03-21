import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/routing/router.dart';
import '../../../../../core/utils/exceptions/app_exception.dart';
import '../../../../../core/utils/extensions/bool.dart';
import '../../../../../core/utils/extensions/nullable.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/extensions/user.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../../../../domain/models/phone_number.dart';
import '../../../../core/extensions/build_context.dart';
import '../../../../core/extensions/navigator_state.dart';
import '../../../../core/ui/app_dialogs.dart';
import '../../../../core/ui/auth/phone_number_form.dart';
import '../../../../core/ui/callout.dart';
import '../../../../core/ui/dismiss_material_banner_button.dart';
import '../../../../core/ui/label.dart';
import '../../../../core/ui/utils/app_messenger.dart';

@immutable
class PhoneNumberEditDialog extends HookConsumerWidget {
  const PhoneNumberEditDialog({super.key});

  static final LabeledGlobalKey<FormState> formKey = WidgetKeys.phoneNumberForm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final authRepository = ref.watch(authRepositoryProvider.notifier);

    final isLoading = useState<bool>(false);
    final errorMessage = useState<String?>(null);

    void showErrorMessage(AppException appException) {
      errorMessage.value = appException.message;
      isLoading.value = false;
    }

    final currentUser = ref.watch(authRepositoryProvider).value;
    final currentPhoneNumber = useMemoized<PhoneNumber>(
      () => .parseE164(currentUser?.phoneNumber, l10n: l10n).when(
        (phoneNumber) => phoneNumber,
        (appException) {
          showErrorMessage(appException);

          return const PhoneNumber();
        },
      ),
      [currentUser?.phoneNumber],
    );

    final phoneNumber = useState<PhoneNumber>(currentPhoneNumber);

    Future<void> sendVerificationCode() async {
      isLoading.value = true;

      if (!(formKey.currentState?.validate()).orFalse(
        objectName: 'WidgetKeys.phoneNumberEditForm.currentState',
      )) {
        isLoading.value = false;

        return;
      }

      final verificationResult = await authRepository.verifyPhoneNumber(
        countryCode: phoneNumber.value.countryCode!,
        nationalNumber: phoneNumber.value.nationalNumber,
        onPhoneNumberUpdated: (phoneNumberUpdateResult) =>
            phoneNumberUpdateResult.when(
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
            ),
        onVerificationFailed: showErrorMessage,
        onCodeSent: (verificationId, forceResendingToken) {
          context.rootNavigator.safePop();

          OTPVerificationScreenRoute(
            verificationId: verificationId,
            forceResendingToken: forceResendingToken,
            $extra: phoneNumber.value,
          ).push<void>(context);
        },
      );

      verificationResult.whenError(showErrorMessage);

      isLoading.value = false;
    }

    Future<void> unlinkPhoneNumber() async {
      final isConfirmed = await AppDialogs.showConfirmationDialog(
        context: context,
        key: WidgetKeys.unlinkPhoneAuthConfirmationDialog,
        icon: Icons.link_off_outlined,
        title: Text(l10n.unlinkPhoneNumber),
        content: l10n.unlinkPhoneNumberConfirmation,
        confirmLabel: l10n.unlink,
      );

      if (isConfirmed ?? false) {
        final unlinkResult = await authRepository.unlinkPhoneAuthProvider();

        unlinkResult.when(
          (_) {},
          showErrorMessage,
        );
      }
    }

    return SelectionArea(
      child: AlertDialog(
        icon: const Icon(Icons.phone_outlined),
        title: Text(l10n.editPhoneNumber),
        content: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          spacing: Spacing.sm.dp,
          children: [
            if (errorMessage.value.isNotNullAndNotEmpty)
              Callout(errorMessage.value!, type: .error),
            Label(
              l10n.currentPhoneNumber,
              child: Text(
                (currentUser?.phoneNumber).orNullString(
                  objectName: 'currentUser?.phoneNumber',
                ),
              ),
            ),
            PhoneNumberForm(
              formKey: formKey,
              phoneNumber: phoneNumber.value,
              onChanged: (number) => phoneNumber.value = number,
              onSubmitted: sendVerificationCode,
              currentPhoneNumber: currentUser?.phoneNumber,
              enabled: !isLoading.value,
            ),
          ],
        ),
        actions: [
          if (currentUser != null && currentUser.hasPhoneAuthProvider)
            TextButton(
              onPressed: isLoading.value ? null : unlinkPhoneNumber,
              child: Text(
                l10n.unlink,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
            ),
          TextButton(
            onPressed: isLoading.value
                ? null
                : () => context.rootNavigator.safePop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: isLoading.value ? null : sendVerificationCode,
            child: isLoading.value
                ? context.loadingIndicator
                : Text(l10n.sendVerificationCode),
          ),
        ],
      ),
    );
  }
}
