import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sealed_countries/sealed_countries.dart';

import '../../../../core/config/constants/spacing.dart';
import '../../../../core/config/constants/text_input_formatters.dart';
import '../../../../core/config/constants/widget_keys.dart';
import '../../../../core/utils/authentications/firebase_auth_validator.dart';
import '../../../../core/utils/authentications/phone_number_generator.dart';
import '../../../../core/utils/extensions/string.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../../../domain/models/phone_number.dart';
import '../../extensions/build_context.dart';
import '../../hooks/use_flushable_debounced_text_editing_controller.dart';
import '../country_picker.dart';
import '../label.dart';

@immutable
class PhoneNumberForm extends HookConsumerWidget {
  const PhoneNumberForm({
    super.key,
    this.formKey,
    this.labelText,
    this.initialValue = const PhoneNumber(),
    this.textInputAction = .done,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
  });

  final GlobalKey<FormState>? formKey;

  final String? labelText;

  final PhoneNumber initialValue;

  final TextInputAction textInputAction;

  final ValueChanged<PhoneNumber>? onChanged;

  final ValueChanged<PhoneNumber>? onSubmitted;

  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final stateRef = useRef<FormFieldState<PhoneNumber>?>(null);

    final nationalNumberManager = useFlushableDebouncedTextEditingController(
      text: initialValue.nationalNumber,
      onDebounced: (nationalNumber) {
        if (nationalNumber == stateRef.value?.value?.nationalNumber) {
          return;
        }

        final state = stateRef.value;

        if (state == null || state.value == null) {
          return;
        }

        final newValue = state.value!.copyWith(nationalNumber: nationalNumber);

        state.didChange(newValue);
        onChanged?.call(newValue);
      },
    );

    return Form(
      key: formKey,
      child: Label(
        labelText ?? l10n.phoneNumber,
        child: FormField<PhoneNumber>(
          builder: (state) {
            stateRef.value = state;

            final currentValue = state.value!;

            final outlineColor = state.hasError
                ? context.colorScheme.error
                : context.colorScheme.outline;

            final exampleNationalNumber = PhoneNumberGenerator.example(
              countryCode: currentValue.countryCode,
            ).nationalNumber.toString();

            return Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                DecoratedBox(
                  key: WidgetKeys.outlineBox,
                  decoration: context.outlinedBoxDecoration(
                    borderColor: outlineColor,
                  ),
                  child: Padding(
                    padding: .symmetric(horizontal: Spacing.xs.dp),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: .min,
                        crossAxisAlignment: .stretch,
                        spacing: Spacing.xs.dp,
                        children: [
                          Row(
                            mainAxisSize: .min,
                            children: [
                              CountryCodePicker(
                                key: WidgetKeys.countryCodePicker,
                                initialCountryCode: initialValue.countryCode,
                                onChanged: (countryCode) {
                                  final newValue = currentValue.copyWith(
                                    countryCode: countryCode,
                                  );

                                  state.didChange(newValue);
                                  onChanged?.call(newValue);
                                },
                                enabled: enabled,
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
                                border: .none,
                                contentPadding: .all(Spacing.xs.dp),
                                prefixIcon:
                                    currentValue
                                        .countryCode
                                        .isNotNullAndNotEmpty
                                    ? Text(
                                        key: WidgetKeys.countryCodeText,
                                        currentValue.countryCode!,
                                        style: context.textTheme.titleMedium,
                                      )
                                    : null,
                                prefixIconConstraints: const BoxConstraints(),
                              ),
                              keyboardType: .phone,
                              textInputAction: textInputAction,
                              autocorrect: false,
                              onSubmitted: (_) {
                                nationalNumberManager.flush();

                                if (!state.validate()) {
                                  return;
                                }

                                onSubmitted?.call(state.value!);
                              },
                              inputFormatters: [
                                TextInputFormatters.nationalNumber,
                              ],
                              enabled: enabled,
                              autofillHints: const [
                                AutofillHints.telephoneNumberNational,
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
                    key: WidgetKeys.errorText,
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
              l10n: l10n,
            );
          },
          initialValue: initialValue,
        ),
      ),
    );
  }
}

@visibleForTesting
@immutable
class CountryCodePicker extends HookConsumerWidget {
  const CountryCodePicker({
    required super.key,
    required this.initialCountryCode,
    required this.onChanged,
    required this.enabled,
  });

  final String? initialCountryCode;

  final ValueChanged<String?> onChanged;

  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CountryPicker<WorldCountry>(
      initialCountry: .list.firstWhereOrNull(
        (country) => country.idd.phoneCode() == initialCountryCode,
      ),
      valueBuilder: (country) => country,
      onChanged: (country) => onChanged(country?.idd.phoneCode()),
      builder: (country) => Row(
        mainAxisSize: .min,
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
        fit: .scaleDown,
        alignment: .centerLeft,
        child: Text(commonName),
      ),
      itemTrailingBuilder: (country, _) => Text(country.idd.phoneCode()),
      searchFilter: (country, commonName, query) =>
          commonName.contains(query) || country.idd.phoneCode().contains(query),
      enabled: enabled,
    );
  }
}
