import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
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
import '../../../../core/ui/callout.dart';
import '../../../../core/ui/email_text_form_field.dart';
import '../../../../core/ui/label.dart';
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
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading.value
              ? null
              : () {
                  if (context.rootNavigator.canPop()) {
                    context.rootNavigator.pop();
                  }
                },
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: isLoading.value
              ? null
              : () async {
                  isLoading.value = true;

                  if (!(WidgetKeys.emailEditForm.currentState?.validate())
                      .orFalse(
                        objectName: 'WidgetKeys.emailEditForm.currentState',
                      )) {
                    isLoading.value = false;
                    return;
                  }

                  await authRepository
                      .verifyBeforeUpdateEmail(
                        emailController.text,
                      )
                      .then(
                        (result) => result.when(
                          (_) {},
                          (appException) =>
                              errorMessage.value = appException.message,
                        ),
                      )
                      .whenComplete(() => isLoading.value = false);
                },
          child: isLoading.value
              ? context.loadingIndicator
              : Text(l10n.sendVerificationEmail),
        ),
      ],
    );
  }
}
