import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/l10n/app_localizations.dart' as l10n;

part 'app_localizations.g.dart';

@Riverpod(keepAlive: true)
class AppLocalizations extends _$AppLocalizations with WidgetsBindingObserver {
  @override
  l10n.AppLocalizations build() {
    final binding = WidgetsBinding.instance..addObserver(this);
    ref.onDispose(() => binding.removeObserver(this));

    return l10n.lookupAppLocalizations(binding.platformDispatcher.locale);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    ref.invalidateSelf();
  }
}
