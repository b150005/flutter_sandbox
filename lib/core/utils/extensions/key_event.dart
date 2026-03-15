import 'package:flutter/services.dart';

enum LogicalKeyAction {
  arrowLeftKeyDown,
  shiftArrowLeftKeyDown,
  arrowRightKeyDown,
  shiftArrowRightKeyDown,
  tabKeyDown,
  shiftTabKeyDown,
}

extension KeyEventExtension on KeyEvent {
  LogicalKeyAction? get action => switch (this) {
    KeyDownEvent() when logicalKey == LogicalKeyboardKey.arrowLeft =>
      HardwareKeyboard.instance.isShiftPressed
          ? LogicalKeyAction.shiftArrowLeftKeyDown
          : LogicalKeyAction.arrowLeftKeyDown,
    KeyDownEvent() when logicalKey == LogicalKeyboardKey.arrowRight =>
      HardwareKeyboard.instance.isShiftPressed
          ? LogicalKeyAction.shiftArrowRightKeyDown
          : LogicalKeyAction.arrowRightKeyDown,
    KeyDownEvent() when logicalKey == LogicalKeyboardKey.tab =>
      HardwareKeyboard.instance.isShiftPressed
          ? LogicalKeyAction.shiftTabKeyDown
          : LogicalKeyAction.tabKeyDown,
    _ => null,
  };
}
