import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/text_input_formatters.dart';
import '../../../core/config/constants/widget_keys.dart';
import '../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../core/utils/l10n/app_localizations.dart';

@Preview(name: 'Email Text Form Field')
Widget emailTextFormField() => const ProviderScope(child: EmailTextFormField());

@immutable
class EmailTextFormField extends HookConsumerWidget {
  const EmailTextFormField({
    super.key,
    this.controller,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return TextFormField(
      key: WidgetKeys.email,
      controller: controller,
      decoration: InputDecoration(hintText: l10n.email),
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      autocorrect: false,
      validator: (email) =>
          FirebaseAuthValidator.validateEmail(email, l10n: l10n),
      inputFormatters: [TextInputFormatters.noWhitespace],
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
