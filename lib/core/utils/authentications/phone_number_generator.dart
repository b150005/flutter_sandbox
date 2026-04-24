import 'package:dlibphonenumber/dlibphonenumber.dart';

import '../extensions/nullable.dart';
import 'phone_number_parser.dart';

abstract final class PhoneNumberGenerator {
  const PhoneNumberGenerator._();

  static PhoneNumber example({String? countryCode}) => PhoneNumberUtil.instance
      .getExampleNumberForType(
        regionCode: PhoneNumberParser.regionCodeFromCountryCode(
          countryCode,
        ),
        type: PhoneNumberType.mobile,
      )
      .orElse(
        PhoneNumberUtil.instance.getExampleNumberForType(
          type: PhoneNumberType.mobile,
        )!,
        objectName:
            'PhoneNumberUtil.instance.getExampleNumberForType('
            'regionCode: $countryCode, '
            'type: PhoneNumberType.mobile)',
      );
}
