import 'package:logger/logger.dart' as logger;

import '../logging/log_message.dart';
import '../logging/logger.dart';

extension NullSafetyExtension<T> on T? {
  /// `null` の場合はデフォルト値を返す
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

  /// `null` でない場合のみ操作を実行する
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
}
