import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/text_input_formatters.dart';
import '../../../core/config/constants/widget_keys.dart';
import '../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../core/utils/extensions/build_context.dart';
import '../../../core/utils/l10n/app_localizations.dart';
import 'label.dart';

@Preview(name: 'PasswordTextFormField')
Widget passwordTextFormField() =>
    const ProviderScope(child: PasswordTextFormField());

@immutable
class PasswordTextFormField extends HookConsumerWidget {
  const PasswordTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.textInputAction,
    this.onChanged,
    this.validator,
  });

  final TextEditingController? controller;

  final String? labelText;

  final TextInputAction? textInputAction;

  final void Function(String password)? onChanged;

  final String? Function(String? password)? validator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final obscureText = useState<bool>(true);

    final label = labelText ?? l10n.password;

    return Label(
      label,
      child: TextFormField(
        key: WidgetKeys.password,
        controller: controller,
        decoration: context.outlinedInputDecoration.copyWith(
          hintText: label,
          suffixIcon: IconButton(
            key: WidgetKeys.togglePasswordVisibility,
            onPressed: () => obscureText.value = !obscureText.value,
            icon: Icon(
              obscureText.value
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: textInputAction,
        obscureText: obscureText.value,
        autocorrect: false,
        enableSuggestions: false,
        maxLength: FirebaseAuthValidator.passwordMaxLength,
        onChanged: onChanged,
        validator:
            validator ??
            (password) =>
                FirebaseAuthValidator.validatePassword(password, l10n: l10n),
        inputFormatters: [TextInputFormatters.noWhitespace],
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
