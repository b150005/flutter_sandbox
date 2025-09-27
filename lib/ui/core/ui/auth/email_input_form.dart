import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/config/constants/button_size.dart';
import '../../../../core/config/constants/spacing.dart';
import '../../../../core/config/constants/widget_keys.dart';
import '../../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../../core/utils/exceptions/app_exception.dart';
import '../../../../core/utils/extensions/string.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../callout.dart';
import '../email_text_form_field.dart';

@Preview(name: 'Email Input Form')
Widget emailInputForm() => ProviderScope(
  child: EmailInputForm<void>(
    onSubmit: (email) async => const Result.success(null),
    onSuccess: (_) {},
  ),
);

class EmailInputForm<T> extends HookConsumerWidget {
  const EmailInputForm({
    super.key,
    required this.onSubmit,
    required this.onSuccess,
  });

  final Future<Result<T, AppException>> Function(String email) onSubmit;

  final void Function(T result) onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final errorMessage = useState<String?>(null);

    final emailController = useTextEditingController();

    final isLoading = useState<bool>(false);

    return Form(
      key: WidgetKeys.emailVerificationForm,
      child: Column(
        spacing: Spacing.sm.dp,
        children: [
          if (errorMessage.value.isNotNullAndNotEmpty)
            Callout(
              errorMessage.value!,
              type: CalloutType.error,
              onDismiss: () => errorMessage.value = null,
            ),
          EmailTextFormField(
            controller: emailController,
            textInputAction: TextInputAction.done,
          ),
          FilledButton(
            key: WidgetKeys.verifyEmail,
            onPressed: isLoading.value
                ? null
                : () async {
                    isLoading.value = true;

                    errorMessage.value = FirebaseAuthValidator.validateEmail(
                      emailController.text,
                      l10n: l10n,
                    );

                    if (errorMessage.value != null) {
                      isLoading.value = false;
                      return;
                    }

                    await onSubmit(emailController.text)
                        .then(
                          (result) => result.when(
                            onSuccess,
                            (appException) {
                              errorMessage.value = appException.message;
                            },
                          ),
                        )
                        .whenComplete(() => isLoading.value = false);
                  },
            style: FilledButton.styleFrom(fixedSize: ButtonSize.lg.fullWidth),
            child: isLoading.value
                ? CircularProgressIndicator.adaptive(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  )
                : Text(l10n.submit),
          ),
        ],
      ),
    );
  }
}
