import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../config/l10n/app_localizations.dart';
import '../exceptions/app_exception.dart';
import 'phone_number_parser.dart';

abstract class PhoneNumberFormatter {
  const PhoneNumberFormatter._();

  static Result<String, AppException> formatToE164({
    required String countryCode,
    required String nationalNumber,
    required AppLocalizations l10n,
  }) {
    final parseResult = PhoneNumberParser.parseFromParts(
      countryCode: countryCode,
      nationalNumber: nationalNumber,
      l10n: l10n,
    );

    return parseResult.when(
      (phoneNumber) => .success(
        PhoneNumberUtil.instance.format(phoneNumber, .e164),
      ),
      Result.error,
    );
  }
}
