import 'package:flutter_sandbox/core/utils/authentications/phone_number_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('📞 Generating an Example Phone Number', () {
    group('⚠️ Fall Back Behavior', () {
      test(
        'A null country code'
        ' should fall back to a globally valid mobile example number.',
        () {
          final result = PhoneNumberGenerator.example();

          expect(result.countryCode, isPositive);
          expect(result.nationalNumber, isPositive);
        },
      );

      test(
        'An unresolvable country code'
        ' should fall back to a globally valid mobile example number.',
        () {
          const countryCode = '+999';

          final result = PhoneNumberGenerator.example(
            countryCode: countryCode,
          );

          expect(result.countryCode, isPositive);
          expect(result.nationalNumber, isPositive);
        },
      );
    });
  });
}
