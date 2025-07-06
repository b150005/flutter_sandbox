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
      throw UnimplementedError(LogMessage.canEnterWhitespace);
    }

    if (!Regexes.email.regExp.hasMatch(email.trim())) {
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
      throw UnimplementedError(LogMessage.canEnterWhitespace);
    }

    final trimmed = password.trim();

    if (trimmed.length < passwordMinLength ||
        trimmed.length > passwordMaxLength ||
        !trimmed.contains(Regexes.uppercase.regExp) ||
        !trimmed.contains(Regexes.lowercase.regExp) ||
        !trimmed.contains(Regexes.digit.regExp)) {
      return l10n.nonCompliantPassword;
    }

    return null;
  }
}
