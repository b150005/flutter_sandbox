import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/constants/button_size.dart';
import '../../../../core/config/constants/spacing.dart';
import '../../../../core/config/constants/widget_keys.dart';
import '../../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../../core/utils/extensions/string.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../../../data/repositories/shared_preferences/shared_preferences_repository.dart';
import '../callout.dart';
import '../email_text_form_field.dart';

class EmailVerificationForm extends HookConsumerWidget {
  const EmailVerificationForm({
    super.key,
    required this.emailLink,
    required this.onSuccess,
  });

  final Uri emailLink;
  final void Function(UserCredential credential) onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final errorMessage = useState<String?>(null);

    final emailController = useTextEditingController();

    final sharedPreferencesRepository = ref.watch(
      sharedPreferencesRepositoryProvider,
    );
    final authRepository = ref.watch(authRepositoryProvider.notifier);

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

                    await sharedPreferencesRepository.setString(
                      SharedPreferencesKeys.emailForSignIn.name,
                      emailController.text,
                    );

                    await authRepository
                        .signInWithEmailLink(
                          emailLink: emailLink,
                        )
                        .then(
                          (result) => result.when(
                            onSuccess,
                            (appException) {
                              errorMessage.value = appException.message;
                            },
                          ),
                        );

                    isLoading.value = false;
                  },
            style: FilledButton.styleFrom(fixedSize: ButtonSize.lg.fullWidth),
            child: isLoading.value
                ? const CircularProgressIndicator.adaptive()
                : Text(l10n.verifyEmail),
          ),
        ],
      ),
    );
  }
}
