import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/button_size.dart';
import '../../../core/config/constants/spacing.dart';
import '../../../core/config/constants/widget_keys.dart';
import '../../../core/routing/router.dart';
import '../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../core/utils/extensions/string.dart';
import '../../../core/utils/l10n/app_localizations.dart';
import '../../../core/utils/logging/log_message.dart';
import '../../../data/repositories/firebase/auth/auth_repository.dart';
import 'callout.dart';
import 'password_text_form_field.dart';
import 'status_indicator.dart';

@Preview(name: 'Password Setup Form')
Widget passwordSetupForm() => const ProviderScope(
  child: PasswordSetupForm(
    email: 'test@example.com',
  ),
);

class PasswordSetupForm extends HookConsumerWidget {
  const PasswordSetupForm({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final emailValidationMessage = FirebaseAuthValidator.validateEmail(
      email,
      l10n: l10n,
    );

    if (email.isTrimmedEmpty || emailValidationMessage.isNotNullOrNotEmpty) {
      throw ArgumentError(LogMessage.invalidArgument, 'email');
    }

    final errorMessage = useState<String?>(null);

    final passwordController = useTextEditingController();

    final satisfiesMinLength = useState<bool>(
      FirebaseAuthValidator.satisfiesMinLength(
        passwordController.text,
      ),
    );
    final satisfiesMaxLength = useState<bool>(
      FirebaseAuthValidator.satisfiesMaxLength(
        passwordController.text,
      ),
    );
    final hasUppercase = useState<bool>(
      FirebaseAuthValidator.hasUppercase(passwordController.text),
    );
    final hasLowercase = useState<bool>(
      FirebaseAuthValidator.hasLowercase(passwordController.text),
    );
    final hasDigit = useState<bool>(
      FirebaseAuthValidator.hasDigit(passwordController.text),
    );

    final isLoading = useState<bool>(false);

    return Form(
      key: WidgetKeys.passwordSetupForm,
      child: Column(
        spacing: Spacing.sm.dp,
        children: [
          if (errorMessage.value.isNotNullAndNotEmpty)
            Callout(
              errorMessage.value!,
              type: CalloutType.error,
              onDismiss: () => errorMessage.value = null,
            ),
          PasswordTextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.next,
            onChanged: (password) {
              satisfiesMinLength.value =
                  FirebaseAuthValidator.satisfiesMinLength(
                    password,
                  );
              satisfiesMaxLength.value =
                  FirebaseAuthValidator.satisfiesMaxLength(
                    password,
                  );
              hasUppercase.value = FirebaseAuthValidator.hasUppercase(password);
              hasLowercase.value = FirebaseAuthValidator.hasLowercase(password);
              hasDigit.value = FirebaseAuthValidator.hasDigit(password);
            },
          ),
          PasswordTextFormField(
            key: WidgetKeys.confirmPassword,
            hintText: l10n.confirmPassword,
            textInputAction: TextInputAction.done,
            validator: (confirmPassword) =>
                FirebaseAuthValidator.validateConfirmPassword(
                  confirmPassword,
                  password: passwordController.text,
                  l10n: l10n,
                ),
          ),
          Column(
            spacing: Spacing.xs.dp,
            children: [
              StatusIndicator(
                isValid: satisfiesMinLength.value,
                message: l10n.passwordMinLength,
              ),
              StatusIndicator(
                isValid: satisfiesMaxLength.value,
                message: l10n.passwordMaxLength,
              ),
              StatusIndicator(
                isValid: hasUppercase.value,
                message: l10n.atLeastOneUppercaseCharacter,
              ),
              StatusIndicator(
                isValid: hasLowercase.value,
                message: l10n.atLeastOneLowercaseCharacter,
              ),
              StatusIndicator(
                isValid: hasDigit.value,
                message: l10n.atLeastOneDigit,
              ),
            ],
          ),
          FilledButton(
            key: WidgetKeys.setupPassword,
            onPressed: isLoading.value
                ? null
                : () async {
                    isLoading.value = true;

                    if (WidgetKeys.passwordSetupForm.currentState == null ||
                        !WidgetKeys.passwordSetupForm.currentState!
                            .validate()) {
                      isLoading.value = false;
                      return;
                    }

                    final result = await ref
                        .read(authRepositoryProvider.notifier)
                        .createUserWithEmailAndPassword(
                          email: email.trim(),
                          password: passwordController.text.trim(),
                        );

                    result.when((_) {
                      if (context.mounted) {
                        context.go(FirebaseScreenRoute.absolutePath);
                      }
                    }, (exception) => errorMessage.value = exception.message);

                    isLoading.value = false;
                  },
            style: FilledButton.styleFrom(fixedSize: ButtonSize.lg.fullWidth),
            child: isLoading.value
                ? const CircularProgressIndicator.adaptive()
                : Text(l10n.setUpPassword),
          ),
        ],
      ),
    );
  }
}
