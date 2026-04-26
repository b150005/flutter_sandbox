import 'package:dlibphonenumber/dlibphonenumber.dart';

import '../extensions/string.dart';

abstract class PhoneNumberResolver {
  const PhoneNumberResolver._();

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
