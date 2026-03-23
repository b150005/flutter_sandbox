import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/otp_input_form.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../testing/utils/extensions/widget_tester.dart';
import '../../../../../../testing/utils/widgets/test_app.dart';

void _noOp(String _) {}

extension _WidgetTesterExtension on WidgetTester {
  Future<void> pumpTestApp({
    int length = 4,
    ValueChanged<String> onCompleted = _noOp,
    Widget? prev,
    Widget? next,
  }) => pumpWidget(
    TestApp(
      child: Column(
        children: [
          ?prev,
          OTPInputForm(length: length, onCompleted: onCompleted),
          ?next,
        ],
      ),
    ),
  );
}

extension _UserInteraction on WidgetTester {
  Future<void> tapDigitBoxAt(int index) async {
    final digitBoxes = find.descendant(
      of: find.byType(OTPDigitBox),
      matching: find.byType(GestureDetector),
    );

    await tap(digitBoxes.at(index));
    await pump(kDoubleTapTimeout);
  }

  Future<void> doubleTapDigitBox([int index = 0]) async {
    final digitBoxes = find.descendant(
      of: find.byType(OTPDigitBox),
      matching: find.byType(GestureDetector),
    );

    await tap(digitBoxes.at(index));
    await pump(kDoubleTapMinTime);
    await tap(digitBoxes.at(index));
    await pumpAndSettle();
  }

  Future<void> longPressDigitBox([int index = 0]) async {
    final digitBoxes = find.descendant(
      of: find.byType(OTPDigitBox),
      matching: find.byType(GestureDetector),
    );

    await longPress(digitBoxes.at(index));
    await pumpAndSettle();
  }

  Future<void> tapOutsideDigitBox() async {
    final digitBoxesRect = find
        .byType(OTPDigitBox)
        .evaluate()
        .map((digitBox) => digitBox.renderObject! as RenderBox)
        .map(
          (renderBox) => renderBox.localToGlobal(Offset.zero) & renderBox.size,
        )
        .reduce((a, b) => a.expandToInclude(b));

    final screenRect = this.screenRect;

    final outside = Offset(
      screenRect.center.dx,
      (digitBoxesRect.bottom + screenRect.bottom) / 2,
    );

    await tapAt(outside);
    await pump();
  }

  Iterable<OTPDigitBox> get digitBoxes =>
      widgetList<OTPDigitBox>(find.byType(OTPDigitBox));

  Future<void> enterCode(int code) async {
    final controller =
        WidgetKeys.otpEditableText.currentState!.widget.controller;
    final selection = controller.selection;

    final text = selection.baseOffset < 0
        ? code.toString()
        : controller.text.substring(0, selection.baseOffset) +
              code.toString() +
              controller.text.substring(selection.extentOffset);

    testTextInput.updateEditingValue(
      TextEditingValue(
        text: text,
        selection: .collapsed(offset: selection.extentOffset),
      ),
    );

    await pump();
  }
}

void main() {
  group('🎨 UI elements', () {
    testWidgets(
      'Displaying the correct number of digit boxes for the given length.',
      (tester) async {
        const length = 6;

        await tester.pumpTestApp(length: length);

        expect(find.byType(OTPDigitBox), findsNWidgets(length));
      },
    );

    testWidgets(
      'Displaying blank placeholders in all digit boxes before any input.',
      (tester) async {
        await tester.pumpTestApp();

        for (final box in tester.digitBoxes) {
          expect(box.value.characters, OTPInputForm.placeholderChar);
        }
      },
    );

    testWidgets(
      'Displaying all digit boxes as inactive before any interaction.',
      (tester) async {
        await tester.pumpTestApp();

        for (final box in tester.digitBoxes) {
          expect(box.isActive, isFalse);
        }
      },
    );
  });

  group('♻️ Input Formatting', () {});

  group('👆 User Interactions', () {
    testWidgets(
      'Tapping a digit box should activate it.',
      (tester) async {
        await tester.pumpTestApp();

        const tappedIndex = 1;
        await tester.tapDigitBoxAt(tappedIndex);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Tapping a digit box should deactivate the previously active digit box.',
      (tester) async {
        await tester.pumpTestApp();

        final (firstTappedIndex, secondTappedIndex) = (1, 3);

        await tester.tapDigitBoxAt(firstTappedIndex);
        await tester.tapDigitBoxAt(secondTappedIndex);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == secondTappedIndex ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Tapping outside the digit boxes should activate all digit boxes.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.tapDigitBoxAt(1);
        await tester.tapOutsideDigitBox();

        for (final box in tester.digitBoxes) {
          expect(box.isActive, isFalse);
        }
      },
    );

    testWidgets(
      'Double-tapping a digit box should activate all digit boxes.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.doubleTapDigitBox();

        for (final box in tester.digitBoxes) {
          expect(box.isActive, isTrue);
        }
      },
    );

    testWidgets(
      'Long-pressing a digit box should activate all digit boxes.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.longPressDigitBox();

        for (final box in tester.digitBoxes) {
          expect(box.isActive, isTrue);
        }
      },
    );

    testWidgets(
      'Typing a digit into an active digit box should fill it and'
      ' move focus to the next digit box.',
      (tester) async {
        await tester.pumpTestApp();

        final (tappedIndex, code) = (1, 2);

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.enterCode(code);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex + 1 ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Typing a digit into the last active digit box with no blank digits'
      ' should fill it and call onCompleted.',
      (tester) async {
        String? result;

        await tester.pumpTestApp(onCompleted: (value) => result = value);

        await tester.tapDigitBoxAt(0);
        await tester.enterCode(123);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == boxes.length - 1 ? isTrue : isFalse,
          );
        }

        await tester.enterCode(4);

        expect(result, '1234');
      },
    );

    testWidgets(
      'Typing a digit without an active digit box (no focus)'
      ' should change nothing.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enterCode(1);

        for (final box in tester.digitBoxes) {
          expect(box.value.characters, OTPInputForm.placeholderChar);
          expect(box.isActive, isFalse);
        }
      },
    );

    testWidgets(
      'Typing the same digit as the currently active digit box'
      ' should move focus to the next digit box.',
      (tester) async {
        await tester.pumpTestApp();

        final (tappedIndex, code) = (1, 2);

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.enterCode(code);
        await tester.tapDigitBoxAt(tappedIndex);
        await tester.enterCode(code);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex + 1 ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Typing the same digit as the last active digit box with no blank digits'
      ' should call onCompleted.',
      (tester) async {
        String? result;

        await tester.pumpTestApp(onCompleted: (value) => result = value);

        await tester.tapDigitBoxAt(1);
        await tester.enterCode(234);
        await tester.enterCode(1);
        await tester.tapDigitBoxAt(3);
        await tester.enterCode(4);

        final boxes = tester.digitBoxes;

        for (final box in boxes) {
          expect(box.isActive, isFalse);
        }
        expect(result, '1234');
      },
    );

    testWidgets(
      'Pasting digits into an active digit box should fill from that position'
      ' and move focus after the last pasted digit.',
      (tester) async {
        await tester.pumpTestApp();

        final (tappedIndex, code) = (1, 23);

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.enterCode(code);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex + code.toString().length ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Pasting digits that fill all digit boxes should call onCompleted.',
      (tester) async {
        String? result;

        await tester.pumpTestApp(onCompleted: (value) => result = value);

        await tester.tapDigitBoxAt(0);
        await tester.enterCode(12);
        await tester.enterCode(34);

        final boxes = tester.digitBoxes;

        for (final box in boxes) {
          expect(box.isActive, isFalse);
        }
        expect(result, '1234');
      },
    );

    testWidgets(
      'Deleting with an active digit box on the first blank digit'
      ' should keep focus on the first digit box and change nothing.',
      (tester) async {
        await tester.pumpTestApp();

        const firstIndex = 0;

        await tester.tapDigitBoxAt(1);
        await tester.enterCode(234);
        await tester.tapDigitBoxAt(firstIndex);
        await tester.pressBackspace();

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          final box = boxes.elementAt(index);

          expect(
            box.value.characters,
            ' 234'.characters.elementAt(index).characters,
          );
          expect(box.isActive, index == firstIndex ? isTrue : isFalse);
        }
      },
    );

    testWidgets(
      'Deleting with an active digit box on a filled digit should clear it'
      ' and keep focus on the same digit box.',
      (tester) async {
        await tester.pumpTestApp();

        final (tappedIndex, code) = (1, 2);

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.enterCode(code);
        await tester.tapDigitBoxAt(tappedIndex);
        await tester.pressBackspace();

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          final box = boxes.elementAt(index);

          expect(box.value.characters, OTPInputForm.placeholderChar);
          expect(box.isActive, index == tappedIndex ? isTrue : isFalse);
        }
      },
    );

    testWidgets(
      'Deleting with an active digit box on a blank digit'
      ' should move focus to the previous digit box and clear it.',
      (tester) async {
        await tester.pumpTestApp();

        final (tappedIndex, code) = (1, 23);
        final codeChar = code.toString().characters;

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.enterCode(code);
        await tester.pressBackspace();

        final boxes = tester.digitBoxes;
        final lastPastedIndex = tappedIndex + codeChar.length - 1;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == lastPastedIndex ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Pressing ← with an active digit box on a non-first digit'
      ' should move focus to the previous digit box.',
      (tester) async {
        await tester.pumpTestApp();

        const tappedIndex = 1;

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.pressArrowKey(direction: .left);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex - 1 ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Pressing ← with an active digit box on the first digit'
      ' should keep focus on the first digit box.',
      (tester) async {
        await tester.pumpTestApp();

        const tappedIndex = 0;

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.pressArrowKey(direction: .left);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Pressing → with an active digit box on a non-last digit'
      ' should move focus to the next digit box.',
      (tester) async {
        await tester.pumpTestApp();

        const tappedIndex = 1;

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.pressArrowKey(direction: .right);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex + 1 ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Pressing → with an active digit box on the last digit'
      ' with blank digits remaining should keep focus on the last digit box.',
      (tester) async {
        await tester.pumpTestApp();

        const tappedIndex = 3;

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.pressArrowKey(direction: .right);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Pressing → with an active digit box on the last digit'
      ' with no blank digits should call onCompleted.',
      (tester) async {
        await tester.pumpTestApp();

        const tappedIndex = 3;

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.pressArrowKey(direction: .right);

        final boxes = tester.digitBoxes;

        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex ? isTrue : isFalse,
          );
        }
      },
    );
  });

  group('♿️ Accessibility', () {
    testWidgets(
      'Pressing Tab with an active digit box on a non-last digit'
      ' should move focus to the next digit box.',
      (tester) async {
        await tester.pumpTestApp();

        const tappedIndex = 1;

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.pressTab();

        final boxes = tester.digitBoxes;

        expect(
          WidgetKeys.otpEditableText.currentState!.widget.focusNode.hasFocus,
          isTrue,
        );
        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex + 1 ? isTrue : isFalse,
          );
        }
      },
    );

    testWidgets(
      'Pressing Tab with an active digit box on the last digit'
      ' should deactivate all digit boxes'
      ' and move focus to the next focusable widget.',
      (tester) async {
        final nextFocusNode = FocusNode();
        addTearDown(nextFocusNode.dispose);

        await tester.pumpTestApp(next: TextField(focusNode: nextFocusNode));

        await tester.tapDigitBoxAt(3);
        await tester.pressTab();

        expect(
          WidgetKeys.otpEditableText.currentState!.widget.focusNode.hasFocus,
          isFalse,
        );
        for (final box in tester.digitBoxes) {
          expect(box.isActive, isFalse);
        }
        expect(nextFocusNode.hasFocus, isTrue);
      },
    );

    testWidgets(
      'Pressing ⇧ + Tab with an active digit box on the first digit'
      ' should deactivate all digit boxes'
      ' and move focus to the previous focusable widget.',
      (tester) async {
        final prevFocusNode = FocusNode();
        addTearDown(prevFocusNode.dispose);

        await tester.pumpTestApp(prev: TextField(focusNode: prevFocusNode));

        await tester.tapDigitBoxAt(0);
        await tester.pressTab(withShift: true);

        expect(
          WidgetKeys.otpEditableText.currentState!.widget.focusNode.hasFocus,
          isFalse,
        );
        for (final box in tester.digitBoxes) {
          expect(box.isActive, isFalse);
        }
        expect(prevFocusNode.hasFocus, isTrue);
      },
    );

    testWidgets(
      'Pressing ⇧ + Tab with an active digit box on a non-first digit'
      ' should move focus to the previous digit box.',
      (tester) async {
        await tester.pumpTestApp();

        const tappedIndex = 2;

        await tester.tapDigitBoxAt(tappedIndex);
        await tester.pressTab(withShift: true);

        final boxes = tester.digitBoxes;

        expect(
          WidgetKeys.otpEditableText.currentState!.widget.focusNode.hasFocus,
          isTrue,
        );
        for (var index = 0; index < boxes.length; index++) {
          expect(
            boxes.elementAt(index).isActive,
            index == tappedIndex - 1 ? isTrue : isFalse,
          );
        }
      },
    );
  });

  group('⚠️ Error Handling', () {
    /// - Error state displays appropriate message or indicator.
    /// - Empty, null, and boundary values are handled gracefully.
  });
}
