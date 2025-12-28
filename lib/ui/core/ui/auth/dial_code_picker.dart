import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sealed_countries/sealed_countries.dart';

import '../../../../core/config/constants/spacing.dart';
import '../../../../core/config/constants/widget_keys.dart';
import '../../../../core/utils/extensions/string.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../../../data/providers/world_countries_provider.dart';
import '../../extensions/build_context.dart';
import '../utils/preview/wrapper.dart';

@Preview(name: 'Dial Code Picker', wrapper: wrapper)
Widget dialCodePicker() => const ProviderScope(
  child: Scaffold(body: DialCodePicker()),
);

@immutable
class DialCodePicker extends HookConsumerWidget {
  const DialCodePicker({super.key, this.onSelected});

  final void Function(String? dialCode)? onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final basicTypeLocale = BasicTypedLocale(
      NaturalLanguage.fromAnyCode(
        WidgetsBinding.instance.platformDispatcher.locale.languageCode,
      ),
    );
    final countries = ref.watch(
      worldCountriesProvider(basicTypedLocale: basicTypeLocale),
    );

    return IntrinsicWidth(
      child: DropdownSearch<MapEntry<WorldCountry, String>>(
        popupProps: PopupProps.dialog(
          dialogProps: DialogProps(
            barrierDismissible: true,
            barrierLabel: context.modalBarrierDismissLabel,
            useRootNavigator: false,
          ),
          searchFieldProps: TextFieldProps(
            decoration: context.outlinedInputDecoration.copyWith(
              hintText: l10n.dialCodePickerSearchHint,
            ),
            textInputAction: TextInputAction.search,
          ),
          showSearchBox: true,
          itemBuilder: (context, item, isDisabled, isSelected) => ListTile(
            leading: Text(
              item.key.emoji,
              style: context.textTheme.bodyLarge,
            ),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentGeometry.centerLeft,
              child: Text(item.value),
            ),
            trailing: Text(item.key.idd.phoneCode()),
            tileColor: context.colorScheme.surface,
          ),
        ),
        key: key ?? WidgetKeys.dialCodePicker,
        onSelected: onSelected == null
            ? null
            : (entry) => onSelected!(entry?.key.idd.phoneCode()),
        items: (filter, loadProps) => countries.entries.toList(),
        dropdownBuilder: (context, selectedItem) => selectedItem == null
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  l10n.dialCodePickerSearchHint,
                  style: context.textTheme.bodyMedium,
                ),
              )
            : Row(
                spacing: Spacing.xs.dp,
                children: [
                  if (selectedItem.key.emoji.isNotNullAndNotEmpty)
                    Text(
                      selectedItem.key.emoji,
                      style: context.textTheme.titleLarge,
                    ),
                  Text(selectedItem.key.idd.phoneCode()),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        selectedItem.key.commonNameFor(basicTypeLocale),
                      ),
                    ),
                  ),
                ],
              ),
        compareFn: (entry1, entry2) => entry1.key == entry2.key,
        decoratorProps: DropDownDecoratorProps(
          decoration: context.outlinedInputDecoration,
        ),
      ),
    );
  }
}
