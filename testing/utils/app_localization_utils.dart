import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/l10n/app_localizations.dart'
    as l10n;
import 'package:flutter_sandbox/core/utils/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@visibleForTesting
class AppLocalizationUtils {
  const AppLocalizationUtils._();

  static l10n.AppLocalizations readL10n(WidgetTester tester) =>
      tester.container().read(appLocalizationsProvider);
}
