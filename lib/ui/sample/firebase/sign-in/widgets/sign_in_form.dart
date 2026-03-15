import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/button_size.dart';
import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/routing/router.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../../../core/extensions/build_context.dart';
import '../../../../core/ui/auth/email_text_form_field.dart';
import '../../../../core/ui/auth/password_text_form_field.dart';
import '../../../../core/ui/callout.dart';

@immutable
class SignInForm extends HookConsumerWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = useState<String?>(null);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final isLoading = useState<bool>(false);

    final l10n = ref.watch(appLocalizationsProvider);

    Future<void> onSubmit() async {
      if (isLoading.value) {
        return;
      }

      isLoading.value = true;

      if (WidgetKeys.signInForm.currentState == null ||
          !WidgetKeys.signInForm.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      final signInResult = await ref
          .read(authRepositoryProvider.notifier)
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      signInResult.when(
        (_) {
          TextInput.finishAutofillContext();

          context.go(FirebaseScreenRoute.absolutePath);
        },
        (appException) => errorMessage.value = appException.message,
      );

      isLoading.value = false;
    }

    return AutofillGroup(
      onDisposeAction: .cancel,
      child: Form(
        key: WidgetKeys.signInForm,
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
              textInputAction: .next,
            ),
            PasswordTextFormField(
              controller: passwordController,
              textInputAction: .done,
              onFieldSubmitted: (_) => onSubmit(),
            ),
            Align(
              alignment: .centerRight,
              child: TextButton(
                key: WidgetKeys.forgotPassword,
                onPressed: () =>
                    context.go(ForgotPasswordScreenRoute.absolutePath),
                child: Text(l10n.forgotPassword),
              ),
            ),
            FilledButton(
              key: WidgetKeys.signIn,
              onPressed: onSubmit,
              style: FilledButton.styleFrom(fixedSize: ButtonSize.lg.fullWidth),
              child: isLoading.value
                  ? context.loadingIndicator
                  : Text(l10n.signIn),
            ),
          ],
        ),
      ),
    );
  }
}
