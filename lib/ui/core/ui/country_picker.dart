import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sealed_countries/sealed_countries.dart';

import '../../../core/config/constants/spacing.dart';
import '../../../core/config/constants/widget_keys.dart';
import '../../../data/providers/world_countries_provider.dart';
import '../extensions/build_context.dart';
import 'app_dialogs.dart';

typedef CountryItemBuilder =
    Widget Function(WorldCountry country, String commonName);

@immutable
class CountryPicker<T> extends HookConsumerWidget {
  const CountryPicker({
    super.key,
    this.initialCountry,
    required this.valueBuilder,
    required this.onChanged,
    required this.builder,
    this.itemLeadingBuilder,
    this.itemTitleBuilder,
    this.itemSubtitleBuilder,
    this.itemTrailingBuilder,
    required this.searchFilter,
    this.clearButtonBuilder,
  });

  final WorldCountry? initialCountry;

  final T Function(WorldCountry country) valueBuilder;

  final ValueChanged<T?> onChanged;

  final Widget Function(WorldCountry? country) builder;

  final CountryItemBuilder? itemLeadingBuilder;

  final CountryItemBuilder? itemTitleBuilder;

  final CountryItemBuilder? itemSubtitleBuilder;

  final CountryItemBuilder? itemTrailingBuilder;

  final bool Function(WorldCountry country, String commonName, String query)
  searchFilter;

  final Widget Function(VoidCallback onClear)? clearButtonBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basicTypeLocale = BasicTypedLocale(
      NaturalLanguage.fromAnyCode(
        WidgetsBinding.instance.platformDispatcher.locale.languageCode,
      ),
    );
    final countryNameMap = ref.watch(
      worldCountriesProvider(basicTypedLocale: basicTypeLocale),
    );

    final country = useState<WorldCountry?>(initialCountry);

    void clearSelection() {
      country.value = null;

      onChanged(null);
    }

    return Row(
      key: WidgetKeys.countryPicker,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      // spacing: Spacing.xxs.dp,
      children: [
        InkWell(
          onTap: () async {
            final selectedCountry =
                await AppDialogs.showSearchableListDialog<WorldCountry>(
                  context: context,
                  items: countryNameMap.keys.toList(),
                  itemLeadingBuilder: (country) => itemLeadingBuilder?.call(
                    country,
                    countryNameMap[country]!,
                  ),
                  itemTitleBuilder: (country) =>
                      itemTitleBuilder?.call(country, countryNameMap[country]!),
                  itemSubtitleBuilder: (country) => itemSubtitleBuilder?.call(
                    country,
                    countryNameMap[country]!,
                  ),
                  itemTrailingBuilder: (country) => itemTrailingBuilder?.call(
                    country,
                    countryNameMap[country]!,
                  ),
                  initialSelection: country.value,
                  searchFilter: (country, query) => searchFilter(
                    country,
                    countryNameMap[country]!,
                    query,
                  ),
                );

            final value = selectedCountry == null
                ? null
                : valueBuilder(selectedCountry);

            country.value = selectedCountry;

            onChanged(value);
          },
          child: Padding(
            padding: EdgeInsets.all(Spacing.xs.dp),
            child: builder(country.value),
          ),
        ),
        if (country.value != null)
          clearButtonBuilder?.call(clearSelection) ??
              IconButton(
                onPressed: clearSelection,
                icon: Icon(
                  Icons.clear_rounded,
                  color: context.colorScheme.outline,
                ),
                tooltip: context.deleteButtonTooltip,
              ),
      ],
    );
  }
}
