import 'package:flutter/material.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/otp_input_form.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('⏮️ Deletion', () {
    test(
      'Deleting with a single-digit selection on a blank first digit'
      ' should keep focus on the first digit and change nothing.',
      () {
        final previous = ' 234'.characters;
        const previousSelection = TextSelection(
          baseOffset: 0,
          extentOffset: 1,
        );

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: previous,
          current: '234'.characters,
          previousSelection: previousSelection,
        );

        expect(result, previous);
        expect(selection, previousSelection);
      },
    );

    test(
      'Deleting with a single-digit selection on a blank non-first digit'
      ' should move focus to the previous digit and clear it.',
      () {
        const previousSelection = TextSelection(
          baseOffset: 2,
          extentOffset: 3,
        );

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '12 4'.characters,
          current: '124'.characters,
          previousSelection: previousSelection,
        );

        expect(result, '1  4'.characters);
        expect(selection?.baseOffset, previousSelection.baseOffset - 1);
        expect(selection?.extentOffset, previousSelection.extentOffset - 1);
      },
    );

    test(
      'Deleting with a single-digit selection on a blank digit'
      ' when all digits are blank should keep focus on the first digit'
      ' and change nothing.',
      () {
        final previous = '    '.characters;
        const previousSelection = TextSelection(baseOffset: 0, extentOffset: 1);

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: previous,
          current: '   '.characters,
          previousSelection: previousSelection,
        );

        expect(result, previous);
        expect(selection, previousSelection);
      },
    );

    test(
      'Deleting with a single-digit selection on a filled digit'
      ' should clear it and keep focus on the same digit.',
      () {
        const previousSelection = TextSelection(
          baseOffset: 2,
          extentOffset: 3,
        );

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '1234'.characters,
          current: '124'.characters,
          previousSelection: previousSelection,
        );

        expect(result, '12 4'.characters);
        expect(selection, previousSelection);
      },
    );

    test(
      'Deleting with a multi-digit selection on all filled digits'
      ' should clear all selected digits'
      ' and keep focus on the first selected digit.',
      () {
        const previousSelection = TextSelection(
          baseOffset: 1,
          extentOffset: 3,
        );

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '1234'.characters,
          current: '14'.characters,
          previousSelection: previousSelection,
        );

        expect(result, '1  4'.characters);
        expect(selection?.baseOffset, previousSelection.baseOffset);
        expect(selection?.extentOffset, previousSelection.baseOffset + 1);
      },
    );

    test(
      'Deleting with a multi-digit selection with some blank digits'
      ' should clear all selected digits'
      ' and keep focus on the first selected digit.',
      () {
        const previousSelection = TextSelection(
          baseOffset: 1,
          extentOffset: 3,
        );

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '12 4'.characters,
          current: '14'.characters,
          previousSelection: previousSelection,
        );

        expect(result, '1  4'.characters);
        expect(selection?.baseOffset, previousSelection.baseOffset);
        expect(selection?.extentOffset, previousSelection.baseOffset + 1);
      },
    );

    test(
      'Deleting with a multi-digit selection on all blank digits'
      ' should clear the digit before the selection and move focus to it.',
      () {
        const previousSelection = TextSelection(
          baseOffset: 2,
          extentOffset: 4,
        );

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '12  '.characters,
          current: '12'.characters,
          previousSelection: previousSelection,
        );

        expect(result, '1   '.characters);
        expect(selection?.baseOffset, previousSelection.baseOffset - 1);
        expect(selection?.extentOffset, previousSelection.baseOffset);
      },
    );
  });

  group('1️⃣ Single Input', () {
    test(
      'Typing with a single-digit selection on the last digit'
      ' with no blank digits should fill it and return null selection'
      ' (trigger onCompleted).',
      () {
        final current = '1234'.characters;
        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '123 '.characters,
          current: current,
          previousSelection: const TextSelection(
            baseOffset: 3,
            extentOffset: 4,
          ),
        );

        expect(result, current);
        expect(selection, isNull);
      },
    );

    test(
      'Typing with a single-digit selection on a non-last digit'
      ' should fill it and move focus to the next digit.',
      () {
        const previousSelection = TextSelection(
          baseOffset: 0,
          extentOffset: 1,
        );

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: ' 234'.characters,
          current: '1234'.characters,
          previousSelection: previousSelection,
        );

        expect(result, '1234'.characters);
        expect(selection?.baseOffset, previousSelection.baseOffset + 1);
        expect(selection?.extentOffset, previousSelection.extentOffset + 1);
      },
    );

    test(
      'Typing with a single-digit selection on the last digit'
      ' with blank digits elsewhere should fill it'
      ' and move focus to the first blank digit.',
      () {
        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '1 34'.characters,
          current: '1 35'.characters,
          previousSelection: const TextSelection(
            baseOffset: 3,
            extentOffset: 4,
          ),
        );

        expect(result, '1 35'.characters);
        expect(selection?.baseOffset, 1);
        expect(selection?.extentOffset, 2);
      },
    );

    test(
      'Typing with a multi-digit selection'
      ' should fill the first selected digit, clear the rest,'
      ' and move focus to the next digit.',
      () {
        const previousSelection = TextSelection(
          baseOffset: 1,
          extentOffset: 3,
        );

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '1234'.characters,
          current: '124'.characters,
          previousSelection: previousSelection,
        );

        expect(result, '12 4'.characters);
        expect(selection?.baseOffset, previousSelection.baseOffset + 1);
        expect(selection?.extentOffset, previousSelection.baseOffset + 2);
      },
    );
  });

  group('🔢 Multiple Input', () {
    test(
      'Pasting with a single-digit selection,'
      ' fewer digits than the remaining length, should fill from the selection'
      ' and move focus after the last pasted digit.',
      () {
        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '123 '.characters,
          current: '4523 '.characters,
          previousSelection: const TextSelection(
            baseOffset: 0,
            extentOffset: 1,
          ),
        );

        expect(result, '453 '.characters);
        expect(selection?.baseOffset, 2);
        expect(selection?.extentOffset, 3);
      },
    );

    test(
      'Pasting with a single-digit selection filling all digits'
      ' with no blank digits elsewhere should fill all digits'
      ' and return null selection (trigger onCompleted).',
      () {
        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '1   '.characters,
          current: '1234  '.characters,
          previousSelection: const TextSelection(
            baseOffset: 1,
            extentOffset: 2,
          ),
        );

        expect(result, '1234'.characters);
        expect(selection, isNull);
      },
    );

    test(
      'Pasting with a single-digit selection reaching the last digit'
      ' with blank digits before the selection should fill from the selection'
      ' to the last digit and move focus to the first blank digit.',
      () {
        final (result, selection) = OTPInputForm.nextStateFor(
          previous: ' 23 '.characters,
          current: ' 4563 '.characters,
          previousSelection: const TextSelection(
            baseOffset: 1,
            extentOffset: 2,
          ),
        );

        expect(result, ' 456'.characters);
        expect(selection?.baseOffset, 0);
        expect(selection?.extentOffset, 1);
      },
    );

    test(
      'Pasting with a multi-digit selection, fewer digits'
      ' than the selection length, should fill pasted digits,'
      ' clear remaining selected digits,'
      ' and move focus after the last pasted digit.',
      () {
        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '1234'.characters,
          current: '156'.characters,
          previousSelection: const TextSelection(
            baseOffset: 1,
            extentOffset: 4,
          ),
        );

        expect(result, '156 '.characters);
        expect(selection?.baseOffset, 3);
        expect(selection?.extentOffset, 4);
      },
    );

    test(
      'Pasting with a single-digit selection'
      ' more digits than the remaining length'
      ' should fill only up to the last digit'
      ' and return null selection (trigger onCompleted).',
      () {
        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '1   '.characters,
          current: '12345  '.characters,
          previousSelection: const TextSelection(
            baseOffset: 1,
            extentOffset: 2,
          ),
        );

        expect(result, '1234'.characters);
        expect(selection, isNull);
      },
    );

    test(
      'Pasting with a multi-digit selection filling all digits'
      ' with no blank digits elsewhere should fill all digits'
      ' and return null selection (trigger onCompleted).',
      () {
        final current = '1234'.characters;

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '12  '.characters,
          current: current,
          previousSelection: const TextSelection(
            baseOffset: 2,
            extentOffset: 4,
          ),
        );

        expect(result, current);
        expect(selection, isNull);
      },
    );

    test(
      'Pasting with a multi-digit selection filling all selected digits'
      ' with blank digits remaining before the selection'
      ' should fill all selected digits'
      ' and move focus to the first blank digit.',
      () {
        final current = '1 34'.characters;

        final (result, selection) = OTPInputForm.nextStateFor(
          previous: '1   '.characters,
          current: current,
          previousSelection: const TextSelection(
            baseOffset: 2,
            extentOffset: 4,
          ),
        );

        expect(result, current);
        expect(selection?.baseOffset, 1);
        expect(selection?.extentOffset, 2);
      },
    );
  });

  group('⬅️ Key Event', () {
    test(
      'Pressing ← with a single-digit selection on the first digit'
      ' should keep focus on the first digit.',
      () {
        const previousSelection = TextSelection(baseOffset: 0, extentOffset: 1);

        final selection = OTPInputForm.nextSelectionFor(
          previousSelection: previousSelection,
          currentSelection: const .collapsed(offset: 0),
          current: '1234'.characters,
        );

        expect(selection, previousSelection);
      },
    );

    test(
      'Pressing ← with a single-digit selection on a non-first digit'
      ' should move focus to the previous digit.',
      () {
        const previousSelection = TextSelection(baseOffset: 1, extentOffset: 2);

        final selection = OTPInputForm.nextSelectionFor(
          previousSelection: previousSelection,
          currentSelection: const .collapsed(offset: 1),
          current: '1234'.characters,
        );

        expect(selection?.baseOffset, previousSelection.baseOffset - 1);
        expect(selection?.extentOffset, previousSelection.extentOffset - 1);
      },
    );
  });

  group('➡️ Key Event', () {
    test(
      'Pressing → with a single-digit selection on the last digit'
      ' with blank digits remaining should keep focus on the last digit.',
      () {
        const previousSelection = TextSelection(baseOffset: 3, extentOffset: 4);

        final selection = OTPInputForm.nextSelectionFor(
          previousSelection: previousSelection,
          currentSelection: .collapsed(offset: previousSelection.extentOffset),
          current: ' 234'.characters,
        );

        expect(selection, previousSelection);
      },
    );

    test(
      'Pressing → with a single-digit selection on the last digit'
      ' with no blank digits should return null selection'
      ' (trigger onCompleted).',
      () {
        const previousSelection = TextSelection(
          baseOffset: 3,
          extentOffset: 4,
        );

        final selection = OTPInputForm.nextSelectionFor(
          previousSelection: previousSelection,
          currentSelection: .collapsed(offset: previousSelection.extentOffset),
          current: '1234'.characters,
        );

        expect(selection, isNull);
      },
    );

    test(
      'Pressing → with a single-digit selection on a non-last digit'
      ' should move focus to the next digit.',
      () {
        const previousSelection = TextSelection(baseOffset: 2, extentOffset: 3);

        final selection = OTPInputForm.nextSelectionFor(
          previousSelection: previousSelection,
          currentSelection: .collapsed(offset: previousSelection.extentOffset),
          current: '1234'.characters,
        );

        expect(selection?.baseOffset, previousSelection.baseOffset + 1);
        expect(selection?.extentOffset, previousSelection.extentOffset + 1);
      },
    );
  });

  group('🚨 Error Handling', () {
    test(
      'Calling with a collapsed previousSelection'
      ' should throw an AssertionError.',
      () {
        expect(
          () => OTPInputForm.nextSelectionFor(
            previousSelection: const .collapsed(offset: 0),
            currentSelection: const .collapsed(offset: 1),
            current: '1234'.characters,
          ),
          throwsAssertionError,
        );
      },
    );

    test(
      'Calling with a non-collapsed currentSelection'
      ' should throw an AssertionError.',
      () {
        expect(
          () => OTPInputForm.nextSelectionFor(
            previousSelection: const TextSelection(
              baseOffset: 0,
              extentOffset: 1,
            ),
            currentSelection: const TextSelection(
              baseOffset: 0,
              extentOffset: 2,
            ),
            current: '1234'.characters,
          ),
          throwsAssertionError,
        );
      },
    );

    test(
      'Pressing arrow key'
      ' with a collapsed offset outside the previous selection range'
      ' should throw a StateError.',
      () {
        expect(
          () => OTPInputForm.nextSelectionFor(
            previousSelection: const TextSelection(
              baseOffset: 0,
              extentOffset: 1,
            ),
            currentSelection: const .collapsed(offset: 2),
            current: '1234'.characters,
          ),
          throwsStateError,
        );
      },
    );
  });
}
