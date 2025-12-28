import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/widget_keys.dart';
import '../../../core/utils/l10n/app_localizations.dart';
import '../extensions/build_context.dart';
import 'label.dart';

@immutable
class PhoneNumberFormField extends HookConsumerWidget {
  const PhoneNumberFormField({
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
  static const examplePhoneNumber = '555 123 4567';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return IntrinsicWidth(
      child: Label(
        labelText ?? l10n.phoneNumber,
        // TODO(b150005): dlibphonenumber を用いた自動フォーマット
        child: TextFormField(
          key: key ?? WidgetKeys.phoneNumber,
          controller: controller,
          decoration: context.outlinedInputDecoration.copyWith(
            hintText: examplePhoneNumber,
          ),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          autocorrect: false,
          onFieldSubmitted: onFieldSubmitted,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}
