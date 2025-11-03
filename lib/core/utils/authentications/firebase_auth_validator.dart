import '../../config/constants/regexes.dart';
import '../../config/l10n/app_localizations.dart';
import '../extensions/string.dart';
import '../logging/log_message.dart';

abstract final class FirebaseAuthValidator {
  const FirebaseAuthValidator._();

  static const passwordMinLength = 8;
  static const passwordMaxLength = 4096;

  static String? validateEmail(
    String? email, {
    required AppLocalizations l10n,
  }) {
    if (email.isNullOrEmpty) {
      return l10n.requiredField;
    }

    if (email!.contains(Regexes.whitespace.regExp)) {
      throw ArgumentError.value(email, 'email', LogMessage.canEnterWhitespace);
    }

    if (!Regexes.email.regExp.hasMatch(email)) {
      return l10n.invalidEmailFormat;
    }

    return null;
  }

  static String? validatePassword(
    String? password, {
    required AppLocalizations l10n,
  }) {
    if (password == null) {
      return l10n.requiredField;
    }

    if (password.contains(Regexes.whitespace.regExp)) {
      throw ArgumentError.value(
        password,
        'password',
        LogMessage.canEnterWhitespace,
      );
    }

    if (!satisfiesMinLength(password) ||
        !satisfiesMaxLength(password) ||
        !hasUppercase(password) ||
        !hasLowercase(password) ||
        !hasDigit(password)) {
      return l10n.nonCompliantPassword;
    }

    return null;
  }

  static bool satisfiesMinLength(String password) =>
      password.trim().length >= passwordMinLength;

  static bool satisfiesMaxLength(String password) =>
      password.length <= passwordMaxLength;

  static bool hasUppercase(String password) =>
      password.contains(Regexes.uppercase.regExp);

  static bool hasLowercase(String password) =>
      password.contains(Regexes.lowercase.regExp);

  static bool hasDigit(String password) =>
      password.contains(Regexes.digit.regExp);

  static String? validateConfirmPassword(
    String? confirmPassword, {
    required String password,
    required AppLocalizations l10n,
  }) {
    if (password.isEmpty || confirmPassword.isNullOrEmpty) {
      return l10n.requiredField;
    }

    if (password.contains(Regexes.whitespace.regExp)) {
      throw ArgumentError.value(
        password,
        'password',
        LogMessage.canEnterWhitespace,
      );
    }

    if (confirmPassword!.contains(Regexes.whitespace.regExp)) {
      throw ArgumentError.value(
        confirmPassword,
        'confirmPassword',
        LogMessage.canEnterWhitespace,
      );
    }

    if (password != confirmPassword) {
      return l10n.passwordMismatch;
    }

    return null;
  }
}
