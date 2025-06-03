import 'dart:developer' as developer;
import 'package:logger/logger.dart' as logger;

import 'log_level_converter.dart';

class LogOutput extends logger.LogOutput {
  @override
  void output(logger.OutputEvent event) {
    developer.log(
      event.lines.join('\n'),
      time: event.origin.time,
      level: LogLevelConverter.toInt(event.level),
    );
  }
}
