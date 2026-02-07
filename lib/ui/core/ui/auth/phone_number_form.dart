import 'package:collection/collection.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sealed_countries/sealed_countries.dart';

import '../../../../core/config/constants/spacing.dart';
import '../../../../core/config/constants/text_input_formatters.dart';
import '../../../../core/config/constants/widget_keys.dart';
import '../../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../../core/utils/authentications/phone_number_parser.dart';
import '../../../../core/utils/extensions/string.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../extensions/build_context.dart';
import '../../hooks/use_flushable_debounced_text_editing_controller.dart';
import '../country_picker.dart';
import '../label.dart';

part 'phone_number_form.freezed.dart';

@freezed
abstract class PhoneNumberInput with _$PhoneNumberInput {
  const factory PhoneNumberInput({
    String? countryCode,
    @Default('') String nationalNumber,
  }) = _PhoneNumberInput;
}

@immutable
class PhoneNumberForm extends HookConsumerWidget {
  const PhoneNumberForm({
    super.key,
    this.formKey,
    this.labelText,
    required this.phoneNumber,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    required this.currentPhoneNumber,
  });

  final GlobalKey<FormState>? formKey;

  final String? labelText;

  final PhoneNumberInput phoneNumber;

  final TextInputAction? textInputAction;

  final ValueChanged<PhoneNumberInput>? onChanged;

  final VoidCallback? onSubmitted;

  final String? currentPhoneNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final stateRef = useRef<FormFieldState<PhoneNumberInput>?>(null);

    final nationalNumberManager = useFlushableDebouncedTextEditingController(
      text: phoneNumber.nationalNumber,
      onDebounced: (nationalNumber) {
        final state = stateRef.value;
        if (state == null || state.value == null) {
          return;
        }

        final newValue = state.value!.copyWith(nationalNumber: nationalNumber);

        state.didChange(newValue);
        onChanged?.call(newValue);
      },
    );

    final exampleNationalNumber = useMemoized(
      () => PhoneNumberUtil.instance
          .getExampleNumberForType(
            regionCode: PhoneNumberParser.regionCodeFromCountryCode(
              phoneNumber.countryCode,
            ),
            type: PhoneNumberType.mobile,
          )!
          .nationalNumber
          .toString(),
      [phoneNumber.countryCode],
    );

    return Form(
      key: formKey,
      child: Label(
        labelText ?? l10n.phoneNumber,
        child: FormField<PhoneNumberInput>(
          builder: (state) {
            stateRef.value = state;

            final outlineColor = state.hasError
                ? context.colorScheme.error
                : context.colorScheme.outline;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: context.outlinedBoxDecoration(
                    borderColor: outlineColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.xs.dp),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: Spacing.xs.dp,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _CountryCodePicker(
                                key: WidgetKeys.countryCodePicker,
                                initialCountryCode: phoneNumber.countryCode,
                                onChanged: (countryCode) {
                                  final newValue = state.value!.copyWith(
                                    countryCode: countryCode,
                                  );

                                  onChanged?.call(newValue);
                                  state.didChange(newValue);
                                },
                              ),
                              VerticalDivider(
                                color: outlineColor,
                              ),
                            ],
                          ),
                          Expanded(
                            child: TextField(
                              key: WidgetKeys.nationalNumberTextField,
                              controller: nationalNumberManager.controller,
                              decoration: InputDecoration(
                                hintText: exampleNationalNumber,
                                hintStyle: context.textTheme.titleMedium
                                    ?.copyWith(
                                      color: context.colorScheme.outlineVariant,
                                    ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(Spacing.xs.dp),
                                prefixIcon:
                                    phoneNumber.countryCode.isNotNullAndNotEmpty
                                    ? Text(
                                        phoneNumber.countryCode!,
                                        style: context.textTheme.titleMedium,
                                      )
                                    : null,
                                prefixIconConstraints: const BoxConstraints(),
                              ),
                              keyboardType: TextInputType.phone,
                              textInputAction:
                                  textInputAction ?? TextInputAction.done,
                              autocorrect: false,
                              onSubmitted: (_) {
                                nationalNumberManager.flush();

                                onSubmitted?.call();
                              },
                              inputFormatters: [
                                TextInputFormatters.nationalNumber,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.hasError)
                  Text(
                    state.errorText!,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: outlineColor,
                    ),
                  ),
              ],
            );
          },
          validator: (phoneNumber) {
            return FirebaseAuthValidator.validatePhoneNumber(
              countryCode: phoneNumber!.countryCode,
              nationalNumber: phoneNumber.nationalNumber,
              currentPhoneNumber: currentPhoneNumber,
              l10n: l10n,
            );
          },
          initialValue: phoneNumber,
        ),
      ),
    );
  }
}

@immutable
class _CountryCodePicker extends HookConsumerWidget {
  const _CountryCodePicker({
    required super.key,
    required this.initialCountryCode,
    required this.onChanged,
  });

  final String? initialCountryCode;

  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CountryPicker<WorldCountry>(
      initialCountry: WorldCountry.list.firstWhereOrNull(
        (country) => country.idd.phoneCode() == initialCountryCode,
      ),
      valueBuilder: (country) => country,
      onChanged: (country) => onChanged(country?.idd.phoneCode()),
      builder: (country) => Row(
        mainAxisSize: MainAxisSize.min,
        spacing: Spacing.xs.dp,
        children: [
          Text(country?.emoji ?? '🌐'),
          Icon(
            Icons.expand_more_rounded,
            color: context.colorScheme.outline,
          ),
        ],
      ),
      itemLeadingBuilder: (country, _) => Text(country.emoji),
      itemTitleBuilder: (_, commonName) => FittedBox(
        fit: BoxFit.scaleDown,
        alignment: AlignmentGeometry.centerLeft,
        child: Text(commonName),
      ),
      itemTrailingBuilder: (country, _) => Text(country.idd.phoneCode()),
      searchFilter: (country, commonName, query) =>
          commonName.contains(query) || country.idd.phoneCode().contains(query),
    );
  }
}
