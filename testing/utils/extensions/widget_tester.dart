import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_flutter_view.dart';

enum ArrowKeyDirection { left, right }

extension WidgetTesterExtension on WidgetTester {
  Rect get screenRect => Offset.zero & view.logicalSize;

  Offset outsideOf(Rect rect) {
    final screenRect = this.screenRect;

    return Offset(screenRect.center.dx, (rect.bottom + screenRect.bottom) / 2);
  }

  Future<void> pressBackspace() async {
    await sendKeyEvent(.backspace);
    await pump();
  }

  Future<void> pressArrowKey({required ArrowKeyDirection direction}) async {
    final key = switch (direction) {
      .left => LogicalKeyboardKey.arrowLeft,
      .right => LogicalKeyboardKey.arrowRight,
    };

    await sendKeyEvent(key);
    await pump();
  }

  Future<void> pressTab({bool withShift = false}) async {
    if (withShift) {
      await sendKeyDownEvent(.shift);
    }
    await sendKeyEvent(.tab);
    if (withShift) {
      await sendKeyUpEvent(.shift);
    }
    await pump();
  }
}
