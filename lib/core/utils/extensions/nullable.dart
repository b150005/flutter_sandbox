import 'package:logger/logger.dart' as logger;

import '../logging/log_message.dart';
import '../logging/logger.dart';

extension NullSafetyExtension<T> on T? {
  T orElse(
    T fallback, {
    String? objectName,
    logger.Level level = logger.Level.warning,
  }) {
    if (this == null) {
      if (objectName != null) {
        Logger.instance.custom(LogMessage.nullObject(objectName), level: level);
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
        Logger.instance.custom(LogMessage.nullObject(objectName), level: level);
      }

      return;
    }

    operation(this as T);
  }

  String orNullString({
    String? objectName,
    logger.Level level = logger.Level.warning,
  }) {
    if (this == null) {
      if (objectName != null) {
        Logger.instance.custom(LogMessage.nullObject(objectName), level: level);
      }

      return 'null';
    }

    return toString();
  }
}
