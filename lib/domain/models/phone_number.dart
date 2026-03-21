import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../core/config/l10n/app_localizations.dart';
import '../../core/utils/authentications/phone_number_parser.dart';
import '../../core/utils/exceptions/app_exception.dart';
import '../../core/utils/extensions/string.dart';

part 'phone_number.freezed.dart';
part 'phone_number.g.dart';

@freezed
abstract class PhoneNumber with _$PhoneNumber {
  const factory PhoneNumber({
    String? countryCode,
    @Default('') String nationalNumber,
  }) = _PhoneNumber;

  factory PhoneNumber.fromParsed(dlib.PhoneNumber phoneNumber) => PhoneNumber(
    countryCode: '+${phoneNumber.countryCode}',
    nationalNumber: phoneNumber.nationalNumber.toString(),
  );

  factory PhoneNumber.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberFromJson(json);

  static const extraKey = 'PhoneNumber';

  static Result<PhoneNumber, AppException> parseE164(
    String? phoneNumber, {
    required AppLocalizations l10n,
  }) {
    if (phoneNumber.isNullOrEmpty) {
      return const .success(PhoneNumber());
    }

    return PhoneNumberParser.parse(
      phoneNumber: phoneNumber!,
      l10n: l10n,
    ).when(
      (phoneNumber) => .success(.fromParsed(phoneNumber)),
      Result.error,
    );
  }
}
