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
    KeyDownEvent() when logicalKey == .arrowLeft =>
      HardwareKeyboard.instance.isShiftPressed
          ? .shiftArrowLeftKeyDown
          : .arrowLeftKeyDown,
    KeyDownEvent() when logicalKey == .arrowRight =>
      HardwareKeyboard.instance.isShiftPressed
          ? .shiftArrowRightKeyDown
          : .arrowRightKeyDown,
    KeyDownEvent() when logicalKey == .tab =>
      HardwareKeyboard.instance.isShiftPressed ? .shiftTabKeyDown : .tabKeyDown,
    _ => null,
  };
}
