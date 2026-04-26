import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../config/l10n/app_localizations.dart';
import '../exceptions/app_exception.dart';
import '../exceptions/exception_handler.dart';

abstract class PhoneNumberParser {
  const PhoneNumberParser._();

  static Result<PhoneNumber, AppException> parse({
    required String phoneNumber,
    required AppLocalizations l10n,
  }) => ExceptionHandler.execute(
    () => PhoneNumberUtil.instance.parse(phoneNumber, null),
    l10n: l10n,
  );

  static Result<PhoneNumber, AppException> parseFromParts({
    required String countryCode,
    required String nationalNumber,
    required AppLocalizations l10n,
  }) => parse(phoneNumber: countryCode + nationalNumber, l10n: l10n);
}
