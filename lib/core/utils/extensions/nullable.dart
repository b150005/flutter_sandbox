import 'package:logger/logger.dart' as logger;

import '../logging/log_message.dart';
import '../logging/logger.dart';

extension NullSafetyExtension<T> on T? {
  static const int stackTraceLevel = Logger.defaultStackTraceLevel + 2;

  T orElse(
    T fallback, {
    String? objectName,
    logger.Level level = logger.Level.warning,
  }) {
    if (this == null) {
      if (objectName != null) {
        Logger.instance.custom(
          LogMessage.nullObject(objectName),
          level: level,
          stackTraceLevel: stackTraceLevel,
        );
      }

      return fallback;
    }

    return this!;
  }

  void ifNotNull(
    void Function(T) operation, {
    String? objectName,
    logger.Level level = logger.Level.warning,
  }) {
    if (this == null) {
      if (objectName != null) {
        Logger.instance.custom(
          LogMessage.nullObject(objectName),
          level: level,
          stackTraceLevel: stackTraceLevel,
        );
      }

      return;
    }

    operation(this as T);
  }

  String orNullString({
    String? objectName,
    logger.Level level = logger.Level.info,
  }) {
    if (this == null) {
      if (objectName != null) {
        Logger.instance.custom(
          LogMessage.nullObject(objectName),
          level: level,
          stackTraceLevel: stackTraceLevel,
        );
      }

      return 'null';
    }

    return toString();
  }
}
