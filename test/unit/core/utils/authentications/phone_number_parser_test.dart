import 'package:flutter_sandbox/core/config/l10n/app_localizations_en.dart';
import 'package:flutter_sandbox/core/utils/authentications/phone_number_parser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sealed_countries/sealed_countries.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('🌐 Formatting to E.164 phone number', () {
    group('✅ Valid Input', () {
      test(
        'A US country code (+1) and valid national number'
        ' should return the E.164 string.',
        () {
          const countryCode = '+1';
          const nationalNumber = '2025551234';

          final result = PhoneNumberParser.formatToE164(
            countryCode: countryCode,
            nationalNumber: nationalNumber,
            l10n: l10n,
          );

          expect(result.tryGetSuccess(), '+12025551234');
        },
      );

      test(
        'A Japanese country code (+81) and valid national number'
        ' should return the E.164 string.',
        () {
          const countryCode = '+81';
          const nationalNumber = '9012345678';

          final result = PhoneNumberParser.formatToE164(
            countryCode: countryCode,
            nationalNumber: nationalNumber,
            l10n: l10n,
          );

          expect(result.tryGetSuccess(), '+819012345678');
        },
      );
    });

    group('❌ Invalid Input', () {
      test(
        'An invalid country code should return an Error result.',
        () {
          const countryCode = '+999';
          const nationalNumber = '2025551234';

          final result = PhoneNumberParser.formatToE164(
            countryCode: countryCode,
            nationalNumber: nationalNumber,
            l10n: l10n,
          );

          expect(result.isError(), isTrue);
        },
      );
    });
  });

  group('💡 Resolving Region Code from Country Code', () {
    group('✅ Valid Input', () {
      test(
        'A country code with a leading "+"'
        ' should return the same region code as one without it.',
        () {
          const countryCode = '+1';

          final result = PhoneNumberParser.regionCodeFromCountryCode(
            countryCode,
          );

          expect(result, const WorldCountry.usa().codeShort);
        },
      );

      test(
        'A country code without a leading "+"'
        ' should return the same region code as one with it.',
        () {
          const countryCode = '1';

          final result = PhoneNumberParser.regionCodeFromCountryCode(
            countryCode,
          );

          expect(result, const WorldCountry.usa().codeShort);
        },
      );
    });

    group('❌ Invalid Input', () {
      test('A null country code should return null.', () {
        const String? countryCode = null;

        final result = PhoneNumberParser.regionCodeFromCountryCode(countryCode);

        expect(result, isNull);
      });

      test('An empty country code should return null.', () {
        const countryCode = '';

        final result = PhoneNumberParser.regionCodeFromCountryCode(countryCode);

        expect(result, isNull);
      });

      test('A non-numeric country code should return null.', () {
        const countryCode = 'JP';

        final result = PhoneNumberParser.regionCodeFromCountryCode(countryCode);

        expect(result, isNull);
      });
    });
  });

  group('📞 Generating an Example Phone Number', () {
    group('⚠️ Fall Back Behavior', () {
      test(
        'A null country code'
        ' should fall back to a globally valid mobile example number.',
        () {
          final result = PhoneNumberParser.examplePhoneNumber();

          expect(result.countryCode, isPositive);
          expect(result.nationalNumber, isPositive);
        },
      );

      test(
        'An unresolvable country code'
        ' should fall back to a globally valid mobile example number.',
        () {
          const countryCode = '+999';

          final result = PhoneNumberParser.examplePhoneNumber(
            countryCode: countryCode,
          );

          expect(result.countryCode, isPositive);
          expect(result.nationalNumber, isPositive);
        },
      );
    });
  });
}
