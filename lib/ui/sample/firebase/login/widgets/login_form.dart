import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/button_size.dart';
import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../../../core/ui/callout.dart';
import '../../../../core/ui/email_text_form_field.dart';
import '../../../../core/ui/password_text_form_field.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = useState<String?>(null);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final isLoading = useState<bool>(false);

    final l10n = ref.watch(appLocalizationsProvider);

    return Form(
      key: WidgetKeys.loginForm,
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
            textInputAction: TextInputAction.next,
          ),
          PasswordTextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              key: WidgetKeys.forgotPassword,
              onPressed: () {
                // TODO(b150005): パスワードリセットの実装
              },
              child: Text(l10n.forgotPassword),
            ),
          ),
          FilledButton(
            key: WidgetKeys.login,
            onPressed: () async {
              if (isLoading.value) {
                return;
              }

              isLoading.value = true;

              if (!WidgetKeys.loginForm.currentState!.validate()) {
                isLoading.value = false;
                return;
              }

              final result = await ref
                  .read(authRepositoryProvider.notifier)
                  .signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );

              result.whenError(
                (exception) => errorMessage.value = exception.message,
              );

              isLoading.value = false;
            },
            style: FilledButton.styleFrom(fixedSize: ButtonSize.lg.fullWidth),
            child: isLoading.value
                ? const CircularProgressIndicator.adaptive()
                : Text(l10n.login),
          ),
        ],
      ),
    );
  }
}
