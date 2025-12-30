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

@Preview(name: 'Country Code Picker', wrapper: wrapper)
Widget countryCodePicker() => const ProviderScope(
  child: Scaffold(body: CountryCodePicker()),
);

@immutable
class CountryCodePicker extends HookConsumerWidget {
  const CountryCodePicker({super.key, this.onSelected});

  final void Function(String? countryCode)? onSelected;

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
              hintText: l10n.countryCodePickerSearchHint,
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
        key: key ?? WidgetKeys.countryCodePicker,
        onSelected: onSelected == null
            ? null
            : (item) => onSelected!(item?.key.idd.phoneCode()),
        items: (filter, loadProps) => countries.entries.toList(),
        dropdownBuilder: (context, selectedItem) => Row(
          spacing: Spacing.xs.dp,
          children: [
            Text(
              (selectedItem?.key.emoji).isNullOrEmpty
                  ? '🌐'
                  : selectedItem!.key.emoji,
            ),
            Text(
              selectedItem == null
                  ? l10n.select
                  : selectedItem.key.idd.phoneCode(),
            ),
          ],
        ),
        filterFn: (item, filter) {
          final query = filter.toLowerCase();

          return item.value.toLowerCase().contains(query) ||
              item.key.idd.phoneCode().contains(query);
        },
        compareFn: (item1, item2) => item1.key == item2.key,
        decoratorProps: DropDownDecoratorProps(
          decoration: context.outlinedInputDecoration,
        ),
      ),
    );
  }
}
