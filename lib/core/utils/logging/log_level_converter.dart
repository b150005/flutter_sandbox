import 'package:logger/logger.dart' as logger;
import 'package:logging/logging.dart' as logging;

final class LogLevelConverter {
  const LogLevelConverter._();

  static logging.Level toLoggingLevel(logger.Level level) => switch (level) {
    logger.Level.all => logging.Level.ALL,
    // ignore: deprecated_member_use
    logger.Level.verbose || logger.Level.trace => logging.Level.FINE,
    logger.Level.debug => logging.Level.CONFIG,
    logger.Level.info => logging.Level.INFO,
    logger.Level.warning => logging.Level.WARNING,
    // ignore: deprecated_member_use
    logger.Level.error || logger.Level.wtf => logging.Level.SEVERE,
    logger.Level.fatal => logging.Level.SHOUT,
    // ignore: deprecated_member_use
    logger.Level.nothing || logger.Level.off => logging.Level.OFF,
  };

  static int toInt(logger.Level level) => toLoggingLevel(level).value;
}
