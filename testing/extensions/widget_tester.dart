import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sandbox/core/config/constants/scroll_alignment.dart';
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

  Future<void> scrollInto(
    FinderBase<Element> finder,
    double delta, {
    FinderBase<Element>? scrollable,
    double alignment = ScrollAlignment.center,
  }) async {
    await scrollUntilVisible(finder, delta, scrollable: scrollable);
    await Scrollable.ensureVisible(element(finder), alignment: alignment);
    await pump();
  }
}
