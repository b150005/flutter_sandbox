import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/button_size.dart';
import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/routing/router.dart';
import '../../../../../core/utils/extensions/build_context.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../../../core/ui/callout.dart';
import '../../../../core/ui/email_text_form_field.dart';

@immutable
class SignUpForm extends HookConsumerWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = useState<String?>(null);

    final emailController = useTextEditingController();

    final isLoading = useState<bool>(false);

    final l10n = ref.watch(appLocalizationsProvider);

    return Form(
      key: WidgetKeys.signUpForm,
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
            key: WidgetKeys.signUp,
            onPressed: isLoading.value
                ? null
                : () async {
                    isLoading.value = true;

                    if (WidgetKeys.signUpForm.currentState == null ||
                        !WidgetKeys.signUpForm.currentState!.validate()) {
                      isLoading.value = false;
                      return;
                    }

                    await ref
                        .read(authRepositoryProvider.notifier)
                        .sendSignInLinkToEmail(
                          email: emailController.text.trim(),
                        )
                        .then(
                          (result) => result.when(
                            (_) =>
                                context.go(EmailSentScreenRoute.absolutePath),
                            (appException) =>
                                errorMessage.value = appException.message,
                          ),
                        )
                        .whenComplete(() => isLoading.value = false);
                  },
            style: FilledButton.styleFrom(fixedSize: ButtonSize.lg.fullWidth),
            child: isLoading.value
                ? CircularProgressIndicator.adaptive(
                    backgroundColor: context.colorScheme.onPrimary,
                  )
                : Text(l10n.signUp),
          ),
        ],
      ),
    );
  }
}
