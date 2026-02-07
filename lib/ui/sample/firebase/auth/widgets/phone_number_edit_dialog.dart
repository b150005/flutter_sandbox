import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/authentications/phone_number_parser.dart';
import '../../../../../core/utils/extensions/bool.dart';
import '../../../../../core/utils/extensions/nullable.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/extensions/user.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final authRepository = ref.watch(authRepositoryProvider.notifier);

    final isLoading = useState<bool>(false);
    final errorMessage = useState<String?>(null);

    final currentUser = ref.watch(authRepositoryProvider).value;
    final currentPhoneNumber = useMemoized<PhoneNumberInput>(() {
      if (currentUser == null || currentUser.phoneNumber.isNullOrEmpty) {
        return const PhoneNumberInput();
      }

      return PhoneNumberParser.parse(
        phoneNumber: currentUser.phoneNumber!,
        l10n: l10n,
      ).when<PhoneNumberInput>(
        (phoneNumber) => PhoneNumberInput(
          countryCode: phoneNumber.countryCode.toString(),
          nationalNumber: phoneNumber.nationalNumber.toString(),
        ),
        (appException) {
          errorMessage.value = appException.message;
          return const PhoneNumberInput();
        },
      );
    }, [currentUser?.phoneNumber]);

    final phoneNumber = useState<PhoneNumberInput>(currentPhoneNumber);

    final formKey = WidgetKeys.phoneNumberForm;

    Future<void> onSendVerificationCode() async {
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
                // TODO(b150005): 電話番号の更新成功時の処理
                context.rootNavigator.safePop();

                AppMessenger.showMaterialBanner(
                  MaterialBanner(
                    content: Text(l10n.updatePhoneNumberSuccessfully),
                    leading: const Icon(Icons.phone_outlined),
                    actions: const [DismissMaterialBannerButton()],
                  ),
                );
              },
              (appException) => errorMessage.value = appException.message,
            ),
        onVerificationFailed: (appException) =>
            errorMessage.value = appException.message,
        onCodeSent: (verificationId, forceResendingToken) {
          // TODO(b150005): 認証コード送信時の処理
        },
        onCodeAutoRetrievalTimeout: (verificationId) {
          // TODO(b150005): 自動検証がタイムアウトした場合の処理
        },
      );

      verificationResult.when(
        (_) {},
        (appException) => errorMessage.value = appException.message,
      );

      isLoading.value = false;
    }

    Future<void> onUnlinkPhoneNumber() async {
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
          (appException) => errorMessage.value = appException.message,
        );
      }
    }

    return SelectionArea(
      child: AlertDialog(
        icon: const Icon(Icons.phone_outlined),
        title: Text(l10n.editPhoneNumber),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Spacing.sm.dp,
          children: [
            if (errorMessage.value.isNotNullAndNotEmpty)
              Callout(
                errorMessage.value!,
                type: CalloutType.error,
              ),
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
              onChanged: (phoneNumberInput) =>
                  phoneNumber.value = phoneNumberInput,
              onSubmitted: onSendVerificationCode,
              currentPhoneNumber: currentUser?.phoneNumber,
            ),
          ],
        ),
        actions: [
          if (currentUser != null && currentUser.hasPhoneAuthProvider)
            TextButton(
              onPressed: onUnlinkPhoneNumber,
              child: Text(
                l10n.unlink,
                style: context.defaultTextStyle.copyWith(
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
            onPressed: isLoading.value ? null : onSendVerificationCode,
            child: isLoading.value
                ? context.loadingIndicator
                : Text(l10n.sendVerificationCode),
          ),
        ],
      ),
    );
  }
}
