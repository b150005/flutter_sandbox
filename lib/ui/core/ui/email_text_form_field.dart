import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/text_input_formatters.dart';
import '../../../core/config/constants/widget_keys.dart';
import '../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../core/utils/l10n/app_localizations.dart';
import '../extensions/build_context.dart';
import 'label.dart';
import 'utils/preview/wrapper.dart';

@Preview(name: 'EmailTextFormField', wrapper: wrapper)
Widget emailTextFormField() => const ProviderScope(child: EmailTextFormField());

@immutable
class EmailTextFormField extends HookConsumerWidget {
  const EmailTextFormField({
    super.key,
    this.labelText,
    this.controller,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final String? labelText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final void Function(String email)? onFieldSubmitted;

  static const exampleEmailAddress = 'user@example.com';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return Label(
      labelText ?? l10n.email,
      child: TextFormField(
        key: WidgetKeys.email,
        controller: controller,
        decoration: context.outlinedInputDecoration.copyWith(
          hintText: exampleEmailAddress,
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: textInputAction,
        autocorrect: false,
        onFieldSubmitted: onFieldSubmitted,
        validator: (email) =>
            FirebaseAuthValidator.validateEmail(email, l10n: l10n),
        inputFormatters: [TextInputFormatters.noWhitespace],
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
