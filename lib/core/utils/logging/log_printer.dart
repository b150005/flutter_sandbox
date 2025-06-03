import 'package:logger/logger.dart';

/// @see logger-2.5.0/lib/src/printers/pretty_printer.dart
class LogPrinter extends PrettyPrinter {
  LogPrinter({
    super.stackTraceBeginIndex,
    super.methodCount = 1,
    super.errorMethodCount = 5,
    super.lineLength = 80,
    super.colors,
    super.printEmojis,
    super.dateTimeFormat = DateTimeFormat.onlyTimeAndSinceStart,
    super.excludeBox,
    super.noBoxingByDefault,
    super.excludePaths,
    super.levelColors,
    super.levelEmojis,
  }) {
    PrettyPrinter.startTime ??= DateTime.now();

    final doubleDividerLine = StringBuffer();
    final singleDividerLine = StringBuffer();
    for (var i = 0; i < lineLength - 1; i++) {
      doubleDividerLine.write(PrettyPrinter.doubleDivider);
      singleDividerLine.write(PrettyPrinter.singleDivider);
    }

    _topBorder = '${PrettyPrinter.topLeftCorner}$doubleDividerLine';
    _middleBorder = '${PrettyPrinter.middleCorner}$singleDividerLine';
    _bottomBorder = '${PrettyPrinter.bottomLeftCorner}$doubleDividerLine';

    // Translate excludeBox map (constant if default) to includeBox map
    // with all Level enum possibilities
    _includeBox = {};
    for (final l in Level.values) {
      _includeBox[l] = !noBoxingByDefault;
    }
    excludeBox.forEach((k, v) => _includeBox[k] = !v);
  }

  /// Contains the parsed rules resulting
  /// from [excludeBox] and [noBoxingByDefault].
  late final Map<Level, bool> _includeBox;
  var _topBorder = '';
  var _middleBorder = '';
  var _bottomBorder = '';

  @override
  List<String> log(LogEvent event) {
    final messageStr = stringifyMessage(event.message);

    String? stackTraceStr;
    if (event.error != null) {
      if (errorMethodCount == null || errorMethodCount! > 0) {
        stackTraceStr = formatStackTrace(
          event.stackTrace ?? StackTrace.current,
          errorMethodCount,
        );
      }
    } else if (methodCount == null || methodCount! > 0) {
      stackTraceStr = formatStackTrace(
        event.stackTrace ?? StackTrace.current,
        methodCount,
      );
    }

    final errorStr = event.error?.toString();

    String? timeStr;
    // Keep backwards-compatibility to `printTime` check
    // ignore: deprecated_member_use
    if (printTime) {
      timeStr = getTime(event.time);
    }

    return _formatAndPrint(
      event.level,
      messageStr,
      timeStr,
      errorStr,
      stackTraceStr,
    );
  }

  AnsiColor _getLevelColor(Level level) {
    AnsiColor? color;
    if (colors) {
      color = levelColors?[level] ?? PrettyPrinter.defaultLevelColors[level];
    }
    return color ?? const AnsiColor.none();
  }

  String _getEmoji(Level level) {
    if (printEmojis) {
      final emoji =
          levelEmojis?[level] ?? PrettyPrinter.defaultLevelEmojis[level];
      if (emoji != null) {
        return emoji;
      }
    }
    return '';
  }

  List<String> _formatAndPrint(
    Level level,
    String message,
    String? time,
    String? error,
    String? stacktrace,
  ) {
    final buffer = <String>[];
    final verticalLineAtLevel = (_includeBox[level]!)
        ? '${PrettyPrinter.verticalLine} '
        : '';
    final color = _getLevelColor(level);

    if (_includeBox[level]!) {
      buffer.add(color(_topBorder));
    }

    if (error != null) {
      for (final line in error.split('\n')) {
        buffer.add(color('$verticalLineAtLevel$line'));
      }
      if (_includeBox[level]!) {
        buffer.add(color(_middleBorder));
      }
    }

    final emoji = _getEmoji(level);
    final levelStr = level.name.toUpperCase();
    for (final line in message.split('\n')) {
      buffer.add(color('$verticalLineAtLevel[$emoji$levelStr] $line'));
    }

    if (time != null) {
      buffer.add(color('$verticalLineAtLevel$time'));
    }

    if (stacktrace != null) {
      if (_includeBox[level]!) {
        buffer.add(color(_middleBorder));
      }
      for (final line in stacktrace.split('\n')) {
        buffer.add(color('$verticalLineAtLevel$line'));
      }
    }

    if (_includeBox[level]!) {
      buffer.add(color(_bottomBorder));
    }

    return buffer;
  }
}
