import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_flutter_view.dart';

enum ArrowKeyDirection { left, right }

extension WidgetTesterExtension on WidgetTester {
  Rect get screenRect => Offset.zero & view.logicalSize;

  Future<void> pressBackspace() async {
    await sendKeyEvent(LogicalKeyboardKey.backspace);
    await pump();
  }

  Future<void> pressArrowKey({required ArrowKeyDirection direction}) async {
    final key = switch (direction) {
      ArrowKeyDirection.left => LogicalKeyboardKey.arrowLeft,
      ArrowKeyDirection.right => LogicalKeyboardKey.arrowRight,
    };

    await sendKeyEvent(key);
    await pump();
  }

  Future<void> pressTab({bool withShift = false}) async {
    if (withShift) {
      await sendKeyDownEvent(LogicalKeyboardKey.shift);
    }
    await sendKeyEvent(LogicalKeyboardKey.tab);
    if (withShift) {
      await sendKeyUpEvent(LogicalKeyboardKey.shift);
    }
    await pump();
  }
}
