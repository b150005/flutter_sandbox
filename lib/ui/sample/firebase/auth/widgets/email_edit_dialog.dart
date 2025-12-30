import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/extensions/bool.dart';
import '../../../../../core/utils/extensions/nullable.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../../../core/extensions/build_context.dart';
import '../../../../core/extensions/navigator_state.dart';
import '../../../../core/ui/callout.dart';
import '../../../../core/ui/dismiss_material_banner_button.dart';
import '../../../../core/ui/email_text_form_field.dart';
import '../../../../core/ui/label.dart';
import '../../../../core/ui/utils/app_messenger.dart';

@immutable
class EmailEditDialog extends HookConsumerWidget {
  const EmailEditDialog({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final emailController = useTextEditingController()
      ..text = user.email.orElse('', objectName: 'user.email');

    final isLoading = useState<bool>(false);
    final errorMessage = useState<String?>(null);

    Future<void> onSubmit() async {
      isLoading.value = true;

      if (!(WidgetKeys.emailEditForm.currentState?.validate()).orFalse(
        objectName: 'WidgetKeys.emailEditForm.currentState',
      )) {
        isLoading.value = false;
        return;
      }

      final verificationEmailSendingResult = await ref
          .read(authRepositoryProvider.notifier)
          .verifyBeforeUpdateEmail(emailController.text);

      verificationEmailSendingResult.when((_) {
        context.rootNavigator.pop();

        AppMessenger.showMaterialBanner(
          MaterialBanner(
            content: Text(l10n.sentEmailUpdateVerificationEmail),
            leading: const Icon(Icons.email_outlined),
            actions: const [DismissMaterialBannerButton()],
          ),
        );
      }, (appException) => errorMessage.value = appException.message);

      isLoading.value = false;
    }

    return SelectionArea(
      child: AlertDialog(
        key: key,
        icon: const Icon(Icons.email_outlined),
        title: Text(l10n.editEmail),
        content: Form(
          key: WidgetKeys.emailEditForm,
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
                l10n.currentEmail,
                child: Text(
                  user.email.orNullString(
                    objectName: 'user.email',
                  ),
                ),
              ),
              EmailTextFormField(
                labelText: l10n.newEmail,
                controller: emailController,
                textInputAction: TextInputAction.done,
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
                : Text(l10n.sendVerificationEmail),
          ),
        ],
      ),
    );
  }
}
