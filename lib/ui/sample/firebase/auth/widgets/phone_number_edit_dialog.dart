import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/exceptions/exception_handler.dart';
import '../../../../../core/utils/extensions/bool.dart';
import '../../../../../core/utils/extensions/nullable.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../core/extensions/build_context.dart';
import '../../../../core/extensions/navigator_state.dart';
import '../../../../core/ui/callout.dart';
import '../../../../core/ui/label.dart';
import '../../../../core/ui/phone_number_text_form_field.dart';

@immutable
class PhoneNumberEditDialog extends HookConsumerWidget {
  const PhoneNumberEditDialog({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final controller = useTextEditingController();

    final isLoading = useState<bool>(false);
    final errorMessage = useState<String?>(null);

    Future<void> onSubmit() async {
      isLoading.value = true;

      if (!(WidgetKeys.phoneNumberForm.currentState?.validate()).orFalse(
        objectName: 'WidgetKeys.phoneNumberEditForm.currentState',
      )) {
        errorMessage.value =
            WidgetKeys.nationalNumberTextFormField.currentState?.errorText;
        isLoading.value = false;

        return;
      }

      await ExceptionHandler.executeAsync(
        () async => {
          // TODO(b150005): SMS による電話番号認証の実装
        },
        l10n: l10n,
      );

      isLoading.value = false;
    }

    return SelectionArea(
      child: AlertDialog(
        key: key,
        icon: const Icon(Icons.phone_outlined),
        title: Text(l10n.editPhoneNumber),
        content: Form(
          key: WidgetKeys.phoneNumberForm,
          child: Column(
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
                  user.phoneNumber.orNullString(
                    objectName: 'user.phoneNumber',
                  ),
                ),
              ),
              PhoneNumberTextFormField(
                controller: controller,
                onFieldSubmitted: (_) => onSubmit(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: isLoading.value
                ? null
                : () => context.rootNavigator.safePop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: isLoading.value ? null : onSubmit,
            child: isLoading.value
                ? context.loadingIndicator
                : Text(l10n.sendVerificationCode),
          ),
        ],
      ),
    );
  }
}
