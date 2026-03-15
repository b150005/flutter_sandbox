import 'package:logger/logger.dart' as logger;
import 'package:logging/logging.dart' as logging;

final class LogLevelConverter {
  const LogLevelConverter._();

  static logging.Level toLoggingLevel(logger.Level level) => switch (level) {
    .all => .ALL,
    // ignore: deprecated_member_use
    .verbose || .trace => .FINE,
    .debug => .CONFIG,
    .info => .INFO,
    .warning => .WARNING,
    // ignore: deprecated_member_use
    .error || .wtf => .SEVERE,
    .fatal => .SHOUT,
    // ignore: deprecated_member_use
    .nothing || .off => .OFF,
  };

  static int toInt(logger.Level level) => toLoggingLevel(level).value;
}
