import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/text_input_formatters.dart';
import '../../../core/config/constants/widget_keys.dart';
import '../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../core/utils/l10n/app_localizations.dart';
import '../themes/extensions/input_decoration_styles.dart';

class EmailTextFormField extends HookConsumerWidget {
  const EmailTextFormField({
    super.key = WidgetKeys.email,
    this.controller,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return TextFormField(
      key: key,
      controller: controller,
      decoration: Theme.of(context)
          .extension<InputDecorationStyles>()
          ?.outlined
          .copyWith(hintText: l10n.email),
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
