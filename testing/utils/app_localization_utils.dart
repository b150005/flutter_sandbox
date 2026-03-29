import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/l10n/app_localizations_en.dart';
import 'package:flutter_sandbox/core/config/l10n/app_localizations_ja.dart';

@visibleForTesting
class AppLocalizationUtils {
  const AppLocalizationUtils._();

  static final AppLocalizationsEn en = AppLocalizationsEn();

  static final AppLocalizationsJa ja = AppLocalizationsJa();
}
