import 'package:flutter_sandbox/core/config/l10n/app_localizations_en.dart';
import 'package:flutter_sandbox/core/utils/authentications/firebase_auth_validator.dart';
import 'package:flutter_sandbox/core/utils/logging/log_message.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../testing/auth/auth_test_input.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('✉️ Email Validation', () {
    group('✅ Valid Input', () {
      test('A standard email address should return null.', () {
        final result = FirebaseAuthValidator.validateEmail(
          AuthTestInput.validEmail,
          l10n: l10n,
        );

        expect(result, isNull);
      });

      test('An email address with a subdomain should return null.', () {
        final result = FirebaseAuthValidator.validateEmail(
          AuthTestInput.subdomainEmail,
          l10n: l10n,
        );

        expect(result, isNull);
      });

      test(
        'An email address with a minimum-length TLD should return null.',
        () {
          final result = FirebaseAuthValidator.validateEmail(
            AuthTestInput.minLengthTldEmail,
            l10n: l10n,
          );

          expect(result, isNull);
        },
      );
    });

    group('❌ Invalid Input', () {
      test(
        'A null email should return the required-field error message.',
        () {
          final result = FirebaseAuthValidator.validateEmail(null, l10n: l10n);

          expect(result, l10n.requiredField);
        },
      );

      test(
        'An empty string should return the required-field error message.',
        () {
          final result = FirebaseAuthValidator.validateEmail(
            AuthTestInput.empty,
            l10n: l10n,
          );

          expect(result, l10n.requiredField);
        },
      );

      test(
        'An email containing a whitespace character'
        ' should throw an ArgumentError.',
        () {
          expect(
            () => FirebaseAuthValidator.validateEmail(
              AuthTestInput.whitespaceEmail,
              l10n: l10n,
            ),
            throwsArgumentError,
          );
        },
      );

      test(
        'An email with multiple "@" symbols'
        ' should return the invalid-format error message.',
        () {
          final result = FirebaseAuthValidator.validateEmail(
            AuthTestInput.multipleAtSignEmail,
            l10n: l10n,
          );

          expect(result, l10n.invalidEmailFormat);
        },
      );

      test(
        'An email without on "@" symbol'
        ' should return the invalid-format error message.',
        () {
          final result = FirebaseAuthValidator.validateEmail(
            AuthTestInput.noAtSignEmail,
            l10n: l10n,
          );

          expect(result, l10n.invalidEmailFormat);
        },
      );

      test(
        'An email with a TLD shorter than the minimum length'
        ' should return the invalid-format error message.',
        () {
          final result = FirebaseAuthValidator.validateEmail(
            AuthTestInput.tooShortTldEmail,
            l10n: l10n,
          );

          expect(result, l10n.invalidEmailFormat);
        },
      );

      test(
        'An email with no dot in the domain'
        ' should return the invalid-format error message.',
        () {
          final result = FirebaseAuthValidator.validateEmail(
            AuthTestInput.noDotInDomainEmail,
            l10n: l10n,
          );

          expect(result, l10n.invalidEmailFormat);
        },
      );

      test(
        'An email with an empty local part'
        ' should return the invalid-format error message.',
        () {
          final result = FirebaseAuthValidator.validateEmail(
            AuthTestInput.emptyLocalPartEmail,
            l10n: l10n,
          );

          expect(result, l10n.invalidEmailFormat);
        },
      );
    });
  });

  group('⚖️ Password Requirements Satisfaction', () {
    group('🔽 Minimum Length', () {
      group('✅ Valid Input', () {
        test(
          'A password with exactly the minimum number of characters'
          ' should return true.',
          () {
            final result = FirebaseAuthValidator.satisfiesMinLength(
              AuthTestInput.minLengthPassword,
            );

            expect(result, isTrue);
          },
        );

        test(
          'A password longer than the minimum length should return true.',
          () {
            final result = FirebaseAuthValidator.satisfiesMinLength(
              AuthTestInput.longerThanMinLengthPassword,
            );

            expect(result, isTrue);
          },
        );
      });

      group('❌ Invalid Input', () {
        test(
          'A password one character shorter than the minimum length'
          ' should return false.',
          () {
            final result = FirebaseAuthValidator.satisfiesMinLength(
              AuthTestInput.tooShortPassword,
            );

            expect(result, isFalse);
          },
        );

        test(
          'A password that meets the minimum characters before trimming'
          ' but falls short after trimming should return false.',
          () {
            final result = FirebaseAuthValidator.satisfiesMinLength(
              AuthTestInput.paddedToMinLengthPassword,
            );

            expect(result, isFalse);
          },
        );
      });
    });

    group('🔼 Maximum Length', () {
      group('✅ Valid Input', () {
        test(
          'A password with exactly the maximum characters should return true.',
          () {
            final result = FirebaseAuthValidator.satisfiesMaxLength(
              AuthTestInput.maxLengthPassword,
            );

            expect(result, isTrue);
          },
        );

        test(
          'A password with shorter than the maximum length should return true.',
          () {
            final result = FirebaseAuthValidator.satisfiesMaxLength(
              AuthTestInput.shorterThanMaxLengthPassword,
            );

            expect(result, isTrue);
          },
        );
      });

      group('❌ Invalid Input', () {
        test(
          'A password one character longer than the maximum length'
          ' should return false.',
          () {
            final result = FirebaseAuthValidator.satisfiesMaxLength(
              AuthTestInput.tooLongPassword,
            );

            expect(result, isFalse);
          },
        );

        test(
          'A password one character longer than the maximum length'
          ' that would fit within the maximum length after trimming'
          ' should still return false.',
          () {
            final result = FirebaseAuthValidator.satisfiesMaxLength(
              AuthTestInput.paddedToOverMaxLengthPassword,
            );

            expect(result, isFalse);
          },
        );
      });
    });

    group('🔠 Uppercase', () {
      test(
        'A string containing an uppercase letter should return true.',
        () {
          final result = FirebaseAuthValidator.hasUppercase(
            AuthTestInput.validPassword,
          );

          expect(result, isTrue);
        },
      );

      test('An empty string should return false.', () {
        final result = FirebaseAuthValidator.hasUppercase(AuthTestInput.empty);

        expect(result, isFalse);
      });

      test(
        'A string without any uppercase letters should return false.',
        () {
          final result = FirebaseAuthValidator.hasUppercase(
            AuthTestInput.lowercasePassword,
          );

          expect(result, isFalse);
        },
      );
    });

    group('🔡 Lowercase', () {
      test('A string containing a lowercase letter should return true.', () {
        final result = FirebaseAuthValidator.hasLowercase(
          AuthTestInput.validPassword,
        );

        expect(result, isTrue);
      });

      test('An empty string should return false.', () {
        final result = FirebaseAuthValidator.hasLowercase(AuthTestInput.empty);

        expect(result, isFalse);
      });

      test(
        'A string without any lowercase letters should return false.',
        () {
          final result = FirebaseAuthValidator.hasLowercase(
            AuthTestInput.uppercasePassword,
          );

          expect(result, isFalse);
        },
      );
    });

    group('🔢 Digit', () {
      test('A string containing a digit should return true.', () {
        final result = FirebaseAuthValidator.hasDigit(
          AuthTestInput.validPassword,
        );

        expect(result, isTrue);
      });

      test('An empty string should return false.', () {
        final result = FirebaseAuthValidator.hasDigit(AuthTestInput.empty);

        expect(result, isFalse);
      });

      test('A string without any digits should return false.', () {
        final result = FirebaseAuthValidator.hasDigit(
          AuthTestInput.noDigitPassword,
        );

        expect(result, isFalse);
      });
    });
  });

  group('🔑 Password Validation', () {
    group('✅ Valid Input', () {
      test('A password meeting all requirements should return null.', () {
        final result = FirebaseAuthValidator.validatePassword(
          AuthTestInput.validPassword,
          l10n: l10n,
        );

        expect(result, isNull);
      });
    });

    group('❌ Invalid Input', () {
      test(
        'A null password should return the required-field error message.',
        () {
          final result = FirebaseAuthValidator.validatePassword(
            null,
            l10n: l10n,
          );

          expect(result, l10n.requiredField);
        },
      );

      test(
        'An empty string should return the required-field error message.',
        () {
          final result = FirebaseAuthValidator.validatePassword(
            AuthTestInput.empty,
            l10n: l10n,
          );

          expect(result, l10n.requiredField);
        },
      );

      test(
        'A password containing a whitespace character'
        ' should throw an ArgumentError.',
        () {
          expect(
            () => FirebaseAuthValidator.validatePassword(
              AuthTestInput.whitespacePassword,
              l10n: l10n,
            ),
            throwsArgumentError,
          );
        },
      );

      test(
        'A password shorter than the minimum length'
        ' should return the non-compliant error message.',
        () {
          final result = FirebaseAuthValidator.validatePassword(
            AuthTestInput.tooShortPassword,
            l10n: l10n,
          );

          expect(result, l10n.nonCompliantPassword);
        },
      );

      test(
        'A password longer than the maximum length'
        ' should return the non-compliant error message.',
        () {
          final result = FirebaseAuthValidator.validatePassword(
            AuthTestInput.tooLongPassword,
            l10n: l10n,
          );

          expect(result, l10n.nonCompliantPassword);
        },
      );

      test(
        'A password without an uppercase letter'
        ' should return the non-compliant error message.',
        () {
          final result = FirebaseAuthValidator.validatePassword(
            AuthTestInput.lowercasePassword,
            l10n: l10n,
          );

          expect(result, l10n.nonCompliantPassword);
        },
      );

      test(
        'A password without an lowercase letter'
        ' should return the non-compliant error message.',
        () {
          final result = FirebaseAuthValidator.validatePassword(
            AuthTestInput.uppercasePassword,
            l10n: l10n,
          );

          expect(result, l10n.nonCompliantPassword);
        },
      );

      test(
        'A password without a digit'
        ' should return the non-compliant error message.',
        () {
          final result = FirebaseAuthValidator.validatePassword(
            AuthTestInput.noDigitPassword,
            l10n: l10n,
          );

          expect(result, l10n.nonCompliantPassword);
        },
      );
    });

    group('🔁 Password Confirmation', () {
      group('✅ Valid Input', () {
        test(
          'A confirm password that matches the password should return null.',
          () {
            final result = FirebaseAuthValidator.validateConfirmPassword(
              AuthTestInput.validPassword,
              password: AuthTestInput.validPassword,
              l10n: l10n,
            );

            expect(result, isNull);
          },
        );
      });

      group('❌ Invalid Input', () {
        test(
          'An empty password should return the required-field error message.',
          () {
            final result = FirebaseAuthValidator.validateConfirmPassword(
              AuthTestInput.validPassword,
              password: AuthTestInput.empty,
              l10n: l10n,
            );

            expect(result, l10n.requiredField);
          },
        );

        test(
          'A null confirm password'
          ' should return the required-field error message.',
          () {
            final result = FirebaseAuthValidator.validateConfirmPassword(
              null,
              password: AuthTestInput.validPassword,
              l10n: l10n,
            );

            expect(result, l10n.requiredField);
          },
        );

        test(
          'An empty confirm password'
          ' should return the required-field error message.',
          () {
            final result = FirebaseAuthValidator.validateConfirmPassword(
              AuthTestInput.empty,
              password: AuthTestInput.validPassword,
              l10n: l10n,
            );

            expect(result, l10n.requiredField);
          },
        );

        test(
          'A password containing a whitespace character'
          ' should throw an ArgumentError.',
          () {
            expect(
              () => FirebaseAuthValidator.validateConfirmPassword(
                AuthTestInput.validPassword,
                password: AuthTestInput.whitespacePassword,
                l10n: l10n,
              ),
              throwsArgumentError,
            );
          },
        );

        test(
          'A confirm password containing a whitespace character'
          ' should throw an ArgumentError.',
          () {
            expect(
              () => FirebaseAuthValidator.validateConfirmPassword(
                AuthTestInput.whitespacePassword,
                password: AuthTestInput.validPassword,
                l10n: l10n,
              ),
              throwsArgumentError,
            );
          },
        );

        test(
          'A confirm password that does not match the password'
          ' should return the password-mismatch error message.',
          () {
            final result = FirebaseAuthValidator.validateConfirmPassword(
              '${AuthTestInput.validPassword}!',
              password: AuthTestInput.validPassword,
              l10n: l10n,
            );

            expect(result, l10n.passwordMismatch);
          },
        );
      });
    });
  });

  group('📞 Phone Number Validation', () {
    group('✅ Valid Input', () {
      test(
        'A valid phone number with a valid country code should return null.',
        () {
          const countryCode = '+1';
          const nationalNumber = '2025551234';

          final result = FirebaseAuthValidator.validatePhoneNumber(
            countryCode: countryCode,
            nationalNumber: nationalNumber,
            l10n: l10n,
          );

          expect(result, isNull);
        },
      );
    });

    group('❌ Invalid Input', () {
      test(
        'A null country code'
        ' should return the country-code-required error message.',
        () {
          const String? countryCode = null;
          const nationalNumber = '2025551234';

          final result = FirebaseAuthValidator.validatePhoneNumber(
            countryCode: countryCode,
            nationalNumber: nationalNumber,
            l10n: l10n,
          );

          expect(result, l10n.countryCodeRequired);
        },
      );

      test(
        'An empty country code'
        ' should return the country-code-required error message.',
        () {
          const countryCode = '';
          const nationalNumber = '2025551234';

          final result = FirebaseAuthValidator.validatePhoneNumber(
            countryCode: countryCode,
            nationalNumber: nationalNumber,
            l10n: l10n,
          );

          expect(result, l10n.countryCodeRequired);
        },
      );

      test(
        'An empty national number'
        ' should return the national-number-required error message.',
        () {
          const countryCode = '+1';
          const nationalNumber = '';

          final result = FirebaseAuthValidator.validatePhoneNumber(
            countryCode: countryCode,
            nationalNumber: nationalNumber,
            l10n: l10n,
          );

          expect(result, l10n.nationalNumberRequired);
        },
      );

      test(
        'An invalid national number for the given country code'
        ' should return the invalid-format error message.',
        () {
          const countryCode = '+1';
          const nationalNumber = '0000000000';

          final result = FirebaseAuthValidator.validatePhoneNumber(
            countryCode: countryCode,
            nationalNumber: nationalNumber,
            l10n: l10n,
          );

          expect(result, l10n.invalidPhoneNumberFormat);
        },
      );

      test('An unparsable country code should return an error message.', () {
        const countryCode = '??';
        const nationalNumber = '2025551234';

        final result = FirebaseAuthValidator.validatePhoneNumber(
          countryCode: countryCode,
          nationalNumber: nationalNumber,
          l10n: l10n,
        );

        expect(result, LogMessage.internalError);
      });
    });
  });
}
