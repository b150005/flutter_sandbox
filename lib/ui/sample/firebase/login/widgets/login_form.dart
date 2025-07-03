import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/sizes.dart';
import '../../../../../core/config/constants/text_input_formatters.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../../../core/themes/extensions/input_decoration_styles.dart';
import '../../../../core/ui/callout.dart';

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
          TextFormField(
            key: WidgetKeys.email,
            controller: emailController,
            decoration: Theme.of(context)
                .extension<InputDecorationStyles>()
                ?.outlined
                .copyWith(hintText: l10n.email),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            validator: (email) =>
                FirebaseAuthValidator.validateEmail(email, l10n: l10n),
            inputFormatters: [TextInputFormatters.noWhitespace],
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            key: WidgetKeys.password,
            controller: passwordController,
            decoration: Theme.of(context)
                .extension<InputDecorationStyles>()
                ?.outlined
                .copyWith(hintText: l10n.password),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            maxLength: FirebaseAuthValidator.passwordMaxLength,
            validator: (password) =>
                FirebaseAuthValidator.validatePassword(password, l10n: l10n),
            inputFormatters: [TextInputFormatters.noWhitespace],
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              key: WidgetKeys.forgotPassword,
              onPressed: () {},
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
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                : Text(l10n.login),
          ),
        ],
      ),
    );
  }
}
