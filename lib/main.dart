import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stack_trace/stack_trace.dart';

import 'core/config/init/app_initializer.dart';
import 'core/config/l10n/app_localizations.dart';
import 'core/utils/exception/app_exception.dart';
import 'core/utils/logging/log_message.dart';
import 'core/utils/logging/logger.dart';

void main() {
  Chain.capture(() {
    try {
      AppInitializer.instance.initialize();

      runApp(const App());
    } on AppException {
      // 何もしない
    } on Exception catch (error, stackTrace) {
      Logger.instance.e(
        LogMessage.unhandledError,
        error: error,
        stackTrace: stackTrace,
      );
    }
  });
}

class App extends StatelessWidget {
  const App({super.key});

  static const Iterable<LocalizationsDelegate<dynamic>>
  _localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const _supportedLocales = [Locale('en', 'US'), Locale('ja', 'JP')];

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: _supportedLocales,
    );
  }
}
