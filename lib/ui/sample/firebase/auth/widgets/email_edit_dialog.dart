import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/exceptions/exception_handler.dart';
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
import '../../../../core/ui/utils/preview/preview_mock_data.dart';
import '../../../../core/ui/utils/preview/wrapper.dart';

@Preview(name: 'Email Edit Dialog', wrapper: wrapper)
Widget emailEditDialog() => Builder(
  builder: (context) => TextButton(
    onPressed: () => showAdaptiveDialog<void>(
      context: context,
      builder: (context) => ProviderScope(
        overrides: [
          // ignore: scoped_providers_should_specify_dependencies
          firebaseAuthProvider.overrideWith(
            (_) => PreviewMockData.mockFirebaseAuth,
          ),
        ],
        child: const EmailEditDialog(),
      ),
    ),
    child: const Text('show EmailEditDialog'),
  ),
);

@immutable
class EmailEditDialog extends HookConsumerWidget {
  const EmailEditDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final currentUser = firebaseAuth.currentUser;

    if (currentUser == null) {
      return AlertDialog(
        title: Text(l10n.error),
        content: Text(l10n.authenticationRequired),
      );
    }

    final emailController = useTextEditingController();

    final isLoading = useState<bool>(false);
    final errorMessage = useState<String?>(null);

    final authRepository = ref.watch(authRepositoryProvider.notifier);

    Future<void> onSubmit() async {
      isLoading.value = true;

      if (!(WidgetKeys.emailEditForm.currentState?.validate()).orFalse(
        objectName: 'WidgetKeys.emailEditForm.currentState',
      )) {
        isLoading.value = false;
        return;
      }

      await ExceptionHandler.execute(() async {
        final verificationEmailSendingResult = await authRepository
            .verifyBeforeUpdateEmail(
              emailController.text,
            );

        verificationEmailSendingResult.when((_) {
          context.rootNavigator.pop();

          AppMessenger.showMaterialBanner(
            MaterialBanner(
              content: Text(
                l10n.sentEmailUpdateVerificationEmail,
              ),
              leading: const Icon(Icons.email_outlined),
              actions: const [DismissMaterialBannerButton()],
            ),
          );
        }, (appException) => errorMessage.value = appException.message);
      }, l10n: l10n).whenComplete(() => isLoading.value = false);
    }

    return AlertDialog(
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
                currentUser.email.orNullString(
                  objectName: 'currentUser.email',
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
    );
  }
}
