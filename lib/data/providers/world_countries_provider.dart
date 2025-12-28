import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sealed_countries/sealed_countries.dart';

part 'world_countries_provider.g.dart';

@riverpod
Map<WorldCountry, String> worldCountries(
  Ref ref, {
  required BasicTypedLocale basicTypedLocale,
}) => WorldCountry.list.commonNamesMap(
  options: LocaleMappingOptions(
    mainLocale: basicTypedLocale,
  ),
);
