import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../config/l10n/app_localizations.dart';
import '../exceptions/app_exception.dart';
import '../exceptions/exception_handler.dart';
import '../extensions/string.dart';

abstract final class PhoneNumberParser {
  const PhoneNumberParser._();

  /// @see [Country codes (ISO 3166-1 and ISO 3166-3)](https://www.iso.org/glossary-for-iso-3166.html)
  static const unknownRegion = 'ZZ';

  static Result<PhoneNumber, AppException> parse({
    required String phoneNumber,
    required AppLocalizations l10n,
  }) => ExceptionHandler.execute(
    () => PhoneNumberUtil.instance.parse(phoneNumber, null),
    l10n: l10n,
  );

  static Result<PhoneNumber, AppException> format({
    required String countryCode,
    required String nationalNumber,
    required AppLocalizations l10n,
  }) => parse(phoneNumber: countryCode + nationalNumber, l10n: l10n);

  static Result<String, AppException> formatToE164({
    required String countryCode,
    required String nationalNumber,
    required AppLocalizations l10n,
  }) {
    final parseResult = format(
      countryCode: countryCode,
      nationalNumber: nationalNumber,
      l10n: l10n,
    );

    return parseResult.when(
      (phoneNumber) => Result.success(
        PhoneNumberUtil.instance.format(phoneNumber, PhoneNumberFormat.e164),
      ),
      Result.error,
    );
  }

  static String? regionCodeFromCountryCode(String? countryCode) {
    if (countryCode.isNullOrEmpty) {
      return null;
    }

    final parsed = int.tryParse(
      countryCode!.startsWith('+') ? countryCode.substring(1) : countryCode,
    );
    if (parsed == null) {
      return null;
    }

    return PhoneNumberUtil.instance.getRegionCodeForCountryCode(parsed);
  }
}
