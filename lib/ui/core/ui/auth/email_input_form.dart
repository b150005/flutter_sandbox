import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/config/constants/button_size.dart';
import '../../../../core/config/constants/spacing.dart';
import '../../../../core/config/constants/widget_keys.dart';
import '../../../../core/utils/exceptions/app_exception.dart';
import '../../../../core/utils/exceptions/exception_handler.dart';
import '../../../../core/utils/extensions/bool.dart';
import '../../../../core/utils/extensions/string.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../extensions/build_context.dart';
import '../callout.dart';
import '../email_text_form_field.dart';
import '../utils/preview/wrapper.dart';

@Preview(name: 'Email Input Form', wrapper: wrapper)
Widget emailInputForm() => ProviderScope(
  child: EmailInputForm<void>(
    submitAction: (email) async => const Result.success(null),
    onSuccess: (_) {},
  ),
);

class EmailInputForm<T> extends HookConsumerWidget {
  const EmailInputForm({
    super.key,
    required this.submitAction,
    required this.onSuccess,
  });

  final Future<Result<T, AppException>> Function(String email) submitAction;

  final void Function(T result) onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final errorMessage = useState<String?>(null);

    final emailController = useTextEditingController();

    final isLoading = useState<bool>(false);

    Future<void> onSubmit() async {
      isLoading.value = true;

      if (!(WidgetKeys.emailVerificationForm.currentState?.validate()).orFalse(
        objectName: 'WidgetKeys.emailVerificationForm.currentState',
      )) {
        isLoading.value = false;
        return;
      }

      await ExceptionHandler.execute(() async {
        final actionResult = await submitAction(emailController.text);

        actionResult.when(
          onSuccess,
          (appException) => errorMessage.value = appException.message,
        );
      }, l10n: l10n).whenComplete(() => isLoading.value = false);
    }

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
            onFieldSubmitted: (_) => onSubmit(),
          ),
          FilledButton(
            key: WidgetKeys.verifyEmail,
            onPressed: isLoading.value ? null : onSubmit,
            style: FilledButton.styleFrom(fixedSize: ButtonSize.lg.fullWidth),
            child: isLoading.value
                ? context.loadingIndicator
                : Text(l10n.submit),
          ),
        ],
      ),
    );
  }
}
