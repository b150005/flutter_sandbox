import 'package:flutter/foundation.dart';
import 'package:flutter_sandbox/core/utils/authentications/firebase_auth_validator.dart';

extension _StringExtension on String {
  static const _whitespaces = [
    ' ', // U+0020 space
    '\t', // U+0009 tab
    '\n', // U+000A newline
    '\r', // U+000D carriage return
    '\f', // U+000C form feed
    '\v', // U+000B vertical tab
  ];

  String get withWhitespace {
    final mid = length ~/ 2;
    final head = substring(0, mid);
    final tail = substring(mid);

    final middleWhitespaces = _whitespaces
        .sublist(1, _whitespaces.length - 1)
        .join();

    return '${_whitespaces.first}$head'
        '$middleWhitespaces$tail${_whitespaces.last}';
  }

  String get withWhitespaceForEmail {
    final atIndex = indexOf('@');
    final dotIndex = lastIndexOf('.');

    final local = substring(0, atIndex);
    final domain = substring(atIndex + 1, dotIndex);
    final tld = substring(dotIndex + 1);

    return '${_whitespaces[0]}$local${_whitespaces[1]}'
        '@${_whitespaces[2]}$domain${_whitespaces[3]}'
        '.${_whitespaces[4]}$tld${_whitespaces[5]}';
  }

  String clamped(int length) => this.length >= length
      ? substring(0, length)
      : this * (length ~/ this.length) + substring(0, length % this.length);
}

@visibleForTesting
abstract final class AuthTestInput {
  const AuthTestInput._();

  static const empty = '';

  static const validEmail = 'test@example.com';

  static const subdomainEmail = 'test@example.co.jp';

  static const minLengthTldEmail = 'ex@mp.le';

  static const tooShortTldEmail = 'test@example.c';

  static final String noAtSignEmail = validEmail.replaceAll(
    RegExp(r'@'),
    '',
  );

  static final String multipleAtSignEmail = validEmail.replaceFirst(
    RegExp(r'@'),
    '@@',
  );

  static final String emptyLocalPartEmail = validEmail.replaceFirst(
    RegExp(r'^[^@]+'),
    '',
  );

  static final String noDotInDomainEmail = validEmail.replaceFirst(
    RegExp(r'\.[^.@]+$'),
    '',
  );

  static final String whitespaceEmail = validEmail.withWhitespaceForEmail;

  static const validPassword = 'P@ssw0rd';

  static final String tooShortPassword = validPassword.clamped(
    FirebaseAuthValidator.passwordMinLength - 1,
  );

  static final String paddedToMinLengthPassword = tooShortPassword.padRight(
    FirebaseAuthValidator.passwordMinLength,
  );

  static final String minLengthPassword = validPassword.clamped(
    FirebaseAuthValidator.passwordMinLength,
  );

  static final String longerThanMinLengthPassword = validPassword.clamped(
    FirebaseAuthValidator.passwordMinLength + 1,
  );

  static final String shorterThanMaxLengthPassword = validPassword.clamped(
    FirebaseAuthValidator.passwordMaxLength - 1,
  );

  static final String maxLengthPassword = validPassword.clamped(
    FirebaseAuthValidator.passwordMaxLength,
  );

  static final String paddedToOverMaxLengthPassword = maxLengthPassword
      .padRight(FirebaseAuthValidator.passwordMaxLength + 1);

  static final String tooLongPassword = validPassword.clamped(
    FirebaseAuthValidator.passwordMaxLength + 1,
  );

  static final String lowercasePassword = validPassword.toLowerCase();

  static final String uppercasePassword = validPassword.toUpperCase();

  static const noDigitPassword = 'P@ssword';

  static final String whitespacePassword = validPassword.withWhitespace;
}
