import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/config/constants/button_size.dart';
import '../../../../core/config/constants/spacing.dart';
import '../../../../core/config/constants/widget_keys.dart';
import '../../../../core/utils/exceptions/app_exception.dart';
import '../../../../core/utils/extensions/bool.dart';
import '../../../../core/utils/extensions/string.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../extensions/build_context.dart';
import '../callout.dart';
import 'email_text_form_field.dart';

class EmailInputForm<T> extends HookConsumerWidget {
  const EmailInputForm({
    super.key,
    required this.onSubmit,
    required this.onSuccess,
  });

  final FutureOr<Result<T, AppException>> Function(String email) onSubmit;

  final void Function(T result) onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final errorMessage = useState<String?>(null);

    final emailController = useTextEditingController();

    final isLoading = useState<bool>(false);

    Future<void> submit() async {
      isLoading.value = true;

      if (!(WidgetKeys.emailVerificationForm.currentState?.validate()).orFalse(
        objectName: 'WidgetKeys.emailVerificationForm.currentState',
      )) {
        isLoading.value = false;
        return;
      }

      final actionResult = await onSubmit(emailController.text);
      actionResult.when(
        (result) {
          TextInput.finishAutofillContext();

          onSuccess(result);
        },
        (appException) => errorMessage.value = appException.message,
      );

      isLoading.value = false;
    }

    return AutofillGroup(
      onDisposeAction: .cancel,
      child: Form(
        key: WidgetKeys.emailVerificationForm,
        child: Column(
          spacing: Spacing.sm.dp,
          children: [
            if (errorMessage.value.isNotNullAndNotEmpty)
              Callout(
                errorMessage.value!,
                type: .error,
                onDismiss: () => errorMessage.value = null,
              ),
            EmailTextFormField(
              controller: emailController,
              textInputAction: .done,
              onFieldSubmitted: (_) => submit(),
            ),
            FilledButton(
              key: WidgetKeys.verifyEmail,
              onPressed: isLoading.value ? null : submit,
              style: FilledButton.styleFrom(fixedSize: ButtonSize.lg.fullWidth),
              child: isLoading.value
                  ? context.loadingIndicator
                  : Text(l10n.submit),
            ),
          ],
        ),
      ),
    );
  }
}
