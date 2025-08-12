import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart' as logger;
import 'package:logging/logging.dart' as logging;
import 'package:stack_trace/stack_trace.dart';

import '../../config/env/env.dart';
import 'log_level_converter.dart';
import 'log_output.dart';
import 'log_printer.dart';

/// Firebase Analytics, Crashlytics を統合した Logger
///
/// スタックチェーンを有効化する場合、 `main()` 関数内の処理を `Chain.capture()` で Wrap してください。
///
/// 提供するログレベル:
///   - `trace`: [開発者向け] 詳細なデバッグ情報
///   - `debug`: [開発者向け] システム動作状況に関する詳細情報
///   - `info`: [開発・運用者向け] イベント情報
///   - `warning`: [開発・運用者向け] 潜在的な問題の情報
///   - `error`: [開発・運用者向け] エラー情報
///   - `fatal`: [開発・運用者向け] 即時対応が必要な、重大なエラー情報
///
/// @warning Firebase Analytics, Crashlytics に情報を送信する場合は `info` レベル以上を使用してください。
///
/// @see [Flutter アプリケーションでの効果的なログ出力](https://zenn.dev/honda9135/articles/181ea0d490c073)
class Logger extends logger.Logger {
  Logger._({super.filter, super.printer, super.output, super.level});

  factory Logger.custom({
    logger.LogFilter? filter,
    logger.LogPrinter? printer,
    logger.LogOutput? output,
    logger.Level? level,
  }) =>
      Logger._(filter: filter, printer: printer, output: output, level: level);

  static final instance = Logger._(
    printer: LogPrinter(
      noBoxingByDefault: true,
      dateTimeFormat: logger.DateTimeFormat.none,
    ),
    output: LogOutput(),
    level: kIsProd ? logger.Level.info : null,
  );

  /// データ収集に関するユーザの同意ステータスを設定する
  ///
  /// @see [Configure Analytics data collection and usage](https://firebase.google.com/docs/analytics/configure-data-collection)
  Future<Logger> consent({
    bool? adStorageConsentGranted,
    bool? analyticsStorageConsentGranted,
    bool? adPersonalizationSignalsConsentGranted,
    bool? adUserDataConsentGranted,
    bool? functionalityStorageConsentGranted,
    bool? personalizationStorageConsentGranted,
    bool? securityStorageConsentGranted,
  }) async {
    if (Firebase.apps.isEmpty) {
      return this;
    }

    try {
      await FirebaseAnalytics.instance.setConsent(
        adStorageConsentGranted: adStorageConsentGranted,
        analyticsStorageConsentGranted: analyticsStorageConsentGranted,
        adPersonalizationSignalsConsentGranted:
            adPersonalizationSignalsConsentGranted,
        adUserDataConsentGranted: adUserDataConsentGranted,
        functionalityStorageConsentGranted: functionalityStorageConsentGranted,
        personalizationStorageConsentGranted:
            personalizationStorageConsentGranted,
        securityStorageConsentGranted: securityStorageConsentGranted,
      );
    } on Exception catch (error, stackTrace) {
      w(
        'Failed to set analytics consent',
        error: error,
        stackTrace: stackTrace,
      );
    }

    return this;
  }

  /// Firebase Analytics によるデータ収集を有効化するかどうかを設定する
  ///
  /// @see [Configure Analytics data collection and usage](https://firebase.google.com/docs/analytics/configure-data-collection)
  Future<Logger> analyticsCollectionEnabled({required bool enabled}) async {
    if (Firebase.apps.isEmpty) {
      return this;
    }

    try {
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(enabled);
    } on Exception catch (error, stackTrace) {
      w(
        'Failed to ${enabled ? 'enable' : 'disable'} analytics collection',
        error: error,
        stackTrace: stackTrace,
      );
    }

    return this;
  }

  /// Firebase Analytics のユーザ ID を設定する
  ///
  /// @see [Set a user ID](https://firebase.google.com/docs/analytics/userid)
  Future<Logger> userId(String? id) async {
    if (Firebase.apps.isEmpty) {
      return this;
    }

    try {
      await FirebaseAnalytics.instance.setUserId(id: id);
    } on Exception catch (error, stackTrace) {
      w(
        'Failed to set analytics user id: $id',
        error: error,
        stackTrace: stackTrace,
      );
    }

    return this;
  }

  /// Firebase Analytics に送信する共通イベントパラメータを設定する
  ///
  /// @see [Log events](https://firebase.google.com/docs/analytics/events?platform=flutter)
  Future<Logger> defaultEventParameters(
    Map<String, Object?>? defaultParameters,
  ) async {
    if (Firebase.apps.isEmpty) {
      return this;
    }

    try {
      await FirebaseAnalytics.instance.setDefaultEventParameters(
        defaultParameters,
      );
    } on Exception catch (error, stackTrace) {
      w(
        'Failed to set default analytics event parameters: $defaultParameters',
        error: error,
        stackTrace: stackTrace,
      );
    }

    return this;
  }

  /// Firebase Analytics のユーザプロパティを設定する
  ///
  /// @see [Set user properties](https://firebase.google.com/docs/analytics/user-properties?platform=flutter)
  Future<Logger> userProperty(Map<String, String?> properties) async {
    if (Firebase.apps.isEmpty || properties.isEmpty) {
      return this;
    }

    for (final entry in properties.entries) {
      try {
        await FirebaseAnalytics.instance.setUserProperty(
          name: entry.key,
          value: entry.value,
        );
      } on Exception catch (error, stackTrace) {
        w(
          'Failed to set analytics user property: $entry',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    return this;
  }

  /// Firebase Analytics にスクリーンビューを送信する
  Future<void> logScreenView(
    String? screenClass,
    String? screenName,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  ) async {
    if (Firebase.apps.isEmpty) {
      return;
    }

    try {
      await FirebaseAnalytics.instance.logScreenView(
        screenClass: screenClass,
        screenName: screenName,
        parameters: parameters,
        callOptions: callOptions,
      );
    } on Exception catch (error, stackTrace) {
      w(
        'Failed to track screen transition',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Firebase Analytics にログを送信する
  ///
  /// @see [Log events](https://firebase.google.com/docs/analytics/events?platform=flutter)
  /// @see [About events](https://support.google.com/analytics/topic/13367566)
  Future<void> _logAnalyticsEvent(
    String name, {
    Map<String, String>? parameters,
  }) async {
    if (Firebase.apps.isEmpty) {
      return;
    }

    try {
      return FirebaseAnalytics.instance.logEvent(
        name: name,
        parameters: parameters,
      );
    } on Exception catch (error, stackTrace) {
      super.e(
        'Failed to send analytics event: $name',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Firebase Crashlytics にエラーを記録する
  Future<void> _recordCrashlyticsError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) async {
    if (Firebase.apps.isEmpty) {
      return;
    }

    await FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      reason: reason,
      information: information,
      printDetails: printDetails,
      fatal: fatal,
    );
  }

  /// Firebase Crashlytics にログを送信する
  Future<void> _logCrashlyticsMessage(dynamic message) async {
    if (Firebase.apps.isEmpty) {
      return;
    }

    await FirebaseCrashlytics.instance.log(message.toString());
  }

  /// スタックチェーンからスタックトレースを取得する
  static StackTrace? _stackChain(StackTrace? stackTrace, {int level = 2}) {
    if (stackTrace == null) {
      return Chain.current(level).terse;
    }

    return Chain.forTrace(stackTrace).terse;
  }

  /// 指定されたログレベルでメッセージを出力する
  ///
  /// このメソッドは動的にログレベルを決定したい場合に使用します。
  ///
  /// @remarks 通常は各ログレベル専用のメソッド([t], [d], [i], [w], [e], [f])を使用することを推奨します。
  void custom(
    dynamic message, {
    required logger.Level level,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    switch (LogLevelConverter.toLoggingLevel(level)) {
      case logging.Level.ALL:
      case logging.Level.FINE:
        t(message, time: time, error: error, stackTrace: stackTrace);
      case logging.Level.CONFIG:
        d(message, time: time, error: error, stackTrace: stackTrace);
      case logging.Level.INFO:
        i(message, time: time, error: error, stackTrace: stackTrace);
      case logging.Level.WARNING:
        w(message, time: time, error: error, stackTrace: stackTrace);
      case logging.Level.SEVERE:
        e(message, time: time, error: error, stackTrace: stackTrace);
      case logging.Level.SHOUT:
        f(message, time: time, error: error, stackTrace: stackTrace);
      case logging.Level.OFF:
        break;
    }
  }

  @override
  void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final chain = _stackChain(stackTrace);

    super.t(message, time: time, error: error, stackTrace: chain);
  }

  @override
  void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final chain = _stackChain(stackTrace);

    super.d(message, time: time, error: error, stackTrace: chain);
  }

  @override
  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, String>? parameters,
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
    bool logsAnalyticsEvent = true,
    bool logsCrashlyticsMessage = false,
    bool recordsCrashlyticsError = false,
  }) {
    final chain = _stackChain(stackTrace);

    super.i(message, time: time, error: error, stackTrace: chain);

    if (logsAnalyticsEvent) {
      _logAnalyticsEvent(message.toString(), parameters: parameters);
    }

    if (logsCrashlyticsMessage) {
      _logCrashlyticsMessage(message);
    }

    if (recordsCrashlyticsError) {
      _recordCrashlyticsError(
        error,
        chain,
        reason: reason,
        information: information,
        printDetails: printDetails,
        fatal: fatal,
      );
    }
  }

  @override
  void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, String>? parameters,
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
    bool logsAnalyticsEvent = true,
    bool logsCrashlyticsMessage = false,
    bool recordsCrashlyticsError = false,
  }) {
    final chain = _stackChain(stackTrace);

    super.w(message, time: time, error: error, stackTrace: chain);

    if (logsAnalyticsEvent) {
      _logAnalyticsEvent(message.toString(), parameters: parameters);
    }

    if (logsCrashlyticsMessage) {
      _logCrashlyticsMessage(message);
    }

    if (recordsCrashlyticsError) {
      _recordCrashlyticsError(
        error,
        chain,
        reason: reason,
        information: information,
        printDetails: printDetails,
        fatal: fatal,
      );
    }
  }

  @override
  void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, String>? parameters,
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
    bool logsAnalyticsEvent = true,
    bool logsCrashlyticsMessage = true,
    bool recordsCrashlyticsError = true,
  }) {
    final chain = _stackChain(stackTrace);

    super.e(message, time: time, error: error, stackTrace: chain);

    if (logsAnalyticsEvent) {
      _logAnalyticsEvent(message.toString(), parameters: parameters);
    }

    if (logsCrashlyticsMessage) {
      _logCrashlyticsMessage(message);
    }

    if (recordsCrashlyticsError) {
      _recordCrashlyticsError(
        error,
        chain,
        reason: reason,
        information: information,
        printDetails: printDetails,
        fatal: fatal,
      );
    }
  }

  @override
  void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, String>? parameters,
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = true,
    bool logsAnalyticsEvent = true,
    bool logsCrashlyticsMessage = true,
    bool recordsCrashlyticsError = true,
  }) {
    final chain = _stackChain(stackTrace);

    super.f(message, time: time, error: error, stackTrace: chain);

    if (logsAnalyticsEvent) {
      _logAnalyticsEvent(message.toString(), parameters: parameters);
    }

    if (logsCrashlyticsMessage) {
      _logCrashlyticsMessage(message);
    }

    if (recordsCrashlyticsError) {
      _recordCrashlyticsError(
        error,
        chain,
        reason: reason,
        information: information,
        printDetails: printDetails,
        fatal: fatal,
      );
    }
  }
}
