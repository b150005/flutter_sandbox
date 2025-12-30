import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/spacing.dart';
import '../../../core/config/constants/text_input_formatters.dart';
import '../../../core/config/constants/widget_keys.dart';
import '../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../core/utils/l10n/app_localizations.dart';
import '../extensions/build_context.dart';
import 'auth/country_code_picker.dart';
import 'label.dart';

@immutable
class PhoneNumberTextFormField extends HookConsumerWidget {
  const PhoneNumberTextFormField({
    super.key,
    this.labelText,
    this.controller,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final String? labelText;

  final TextEditingController? controller;

  final TextInputAction? textInputAction;

  final void Function(String phoneNumber)? onFieldSubmitted;

  // TODO(b150005): dlibphonenumber の例を取得
  static const exampleNationalNumber = '5551234567';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final countryCode = useState<String?>(null);

    return Label(
      labelText ?? l10n.phoneNumber,
      child: Wrap(
        spacing: Spacing.sm.dp,
        runSpacing: Spacing.sm.dp,
        children: [
          CountryCodePicker(
            onSelected: (selectedCountryCode) =>
                countryCode.value = selectedCountryCode,
          ),
          IntrinsicWidth(
            child: TextFormField(
              key: key ?? WidgetKeys.nationalNumberTextFormField,
              controller: controller,
              decoration: context.outlinedInputDecoration.copyWith(
                hintText: exampleNationalNumber,
              ),
              keyboardType: TextInputType.phone,
              textInputAction: textInputAction ?? TextInputAction.done,
              autocorrect: false,
              onFieldSubmitted: onFieldSubmitted,
              validator: (nationalNumber) =>
                  FirebaseAuthValidator.validatePhoneNumber(
                    countryCode: countryCode.value,
                    nationalNumber: nationalNumber,
                    l10n: l10n,
                  ),
              errorBuilder: (_, _) => const SizedBox.shrink(),
              inputFormatters: [TextInputFormatters.nationalNumber],
              autovalidateMode: AutovalidateMode.disabled,
            ),
          ),
        ],
      ),
    );
  }
}
