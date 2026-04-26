import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';

import '../../config/constants/regexes.dart';
import '../../config/l10n/app_localizations.dart';
import '../extensions/string.dart';
import '../logging/log_message.dart';
import 'phone_number_parser.dart';

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
    if (password.isNullOrEmpty) {
      return l10n.requiredField;
    }

    if (password!.contains(Regexes.whitespace.regExp)) {
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

  /// 電話番号の有効性を判定する
  ///
  /// [countryCode] 国番号(例: +81)
  /// [nationalNumber] 国際番号(例: 9012345678)
  /// [l10n] ロケールごとのメッセージを保持するローカライゼーション
  static String? validatePhoneNumber({
    required String? countryCode,
    required String nationalNumber,
    required AppLocalizations l10n,
  }) {
    if (countryCode.isNullOrEmpty) {
      return l10n.countryCodeRequired;
    }

    if (nationalNumber.isEmpty) {
      return l10n.nationalNumberRequired;
    }

    final parseResult = PhoneNumberParser.parseFromParts(
      countryCode: countryCode!,
      nationalNumber: nationalNumber,
      l10n: l10n,
    );

    return parseResult.when(
      (phoneNumber) {
        if (!PhoneNumberUtil.instance.isValidNumber(phoneNumber)) {
          return l10n.invalidPhoneNumberFormat;
        }

        return null;
      },
      (appException) => appException.message,
    );
  }

  static bool satisfiesMinLength(String password) =>
      password.trim().characters.length >= passwordMinLength;

  static bool satisfiesMaxLength(String password) =>
      password.characters.length <= passwordMaxLength;

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
