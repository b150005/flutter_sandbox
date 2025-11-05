import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide ProviderObserver;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:stack_trace/stack_trace.dart';

import 'core/config/initialization/app_initializer.dart';
import 'core/config/l10n/app_localizations.dart';
import 'core/routing/router.dart';
import 'core/utils/exceptions/app_exception.dart';
import 'core/utils/extensions/nullable.dart';
import 'core/utils/logging/log_message.dart';
import 'core/utils/logging/logger.dart';
import 'core/utils/logging/provider_observer.dart';
import 'ui/core/themes/extensions/status_colors.dart';
import 'ui/core/ui/utils/app_messenger.dart';

void main() {
  Chain.capture(() async {
    try {
      await AppInitializer.instance.initialize();

      runApp(
        ProviderScope(observers: [ProviderObserver()], child: const App()),
      );
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

@immutable
class App extends ConsumerWidget {
  const App({super.key});

  static const Iterable<LocalizationsDelegate<Object>> localizationsDelegates =
      [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static const supportedLocales = [Locale('en', 'US'), Locale('ja', 'JP')];

  static const breakpoints = [
    Breakpoint(start: 0, end: 767, name: MOBILE),
    Breakpoint(start: 768, end: 1023, name: TABLET),
    Breakpoint(start: 1024, end: double.infinity, name: DESKTOP),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      scaffoldMessengerKey: AppMessenger.key,
      routerConfig: router,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child.orElse(
          const Placeholder(),
          objectName: 'MaterialApp.router child',
        ),
        breakpoints: breakpoints,
      ),
      theme: ThemeData.light(useMaterial3: true).copyWith(
        extensions: [StatusColors.fromSeed()],
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        extensions: [StatusColors.fromSeed(brightness: Brightness.dark)],
      ),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
    );
  }
}
