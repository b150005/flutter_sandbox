import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/constants/spacing.dart';
import '../../../../core/config/constants/text_input_formatters.dart';
import '../../../../core/config/constants/widget_keys.dart';
import '../../../../core/utils/extensions/characters.dart';
import '../../../../core/utils/extensions/key_event.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../extensions/build_context.dart';
import '../../extensions/text_selection.dart';

extension _CharactersExtension on Characters {
  static final Characters blank = OTPInputForm.placeholderChar;

  bool get hasBlank => contains(blank.string);
  bool get isAllBlank => every((value) => value.characters == blank);

  int? get blankIndexOf {
    if (isEmpty) {
      return 0;
    }

    final range = findFirst(blank);
    return range?.stringBeforeLength;
  }
}

enum _EditOperation {
  delete,
  single,
  multiple;

  factory _EditOperation.from({
    required int previousLength,
    required int currentLength,
    required int selectionLength,
  }) => switch (currentLength - previousLength + selectionLength) {
    0 => delete,
    1 => single,
    _ => multiple,
  };
}

@immutable
class OTPInputForm extends HookConsumerWidget {
  const OTPInputForm({
    super.key,
    required this.length,
    required this.onCompleted,
  }) : assert(length > 0);

  final int length;

  static final Characters placeholderChar = ' '.characters;
  Characters get placeholder => (placeholderChar.string * length).characters;

  final ValueChanged<String> onCompleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final controller = useTextEditingController(text: placeholder.string);
    useListenableSelector(controller, () => controller.text);

    final previous = useRef<Characters>(placeholder);

    final activeSelection = useState<TextSelection?>(null);

    void update({
      required Characters value,
      required TextSelection selection,
    }) {
      previous.value = value;
      activeSelection.value = selection;
      controller.value = TextEditingValue(
        text: value.string,
        selection: selection,
      );
    }

    KeyEventResult onKeyEvent(FocusNode node, KeyEvent event) {
      if (activeSelection.value == null) {
        return KeyEventResult.ignored;
      }

      final action = event.action;
      final (current, currentSelection) = (
        controller.text.characters,
        activeSelection.value!,
      );

      switch (action) {
        case LogicalKeyAction.tabKeyDown:
        case LogicalKeyAction.shiftTabKeyDown:
          final isForward = action == LogicalKeyAction.tabKeyDown;
          if ((isForward && currentSelection.extentOffset >= current.length) ||
              (!isForward && currentSelection.baseOffset <= 0)) {
            activeSelection.value = null;
            return KeyEventResult.ignored;
          }

          final nextSelection = OTPInputForm.nextSelectionFor(
            previousSelection: currentSelection,
            currentSelection: TextSelection.collapsed(
              offset: isForward
                  ? currentSelection.extentOffset
                  : currentSelection.baseOffset,
            ),
            current: current,
          );

          if (nextSelection != null) {
            update(value: current, selection: nextSelection);
          }

          return KeyEventResult.handled;
        default:
          return KeyEventResult.ignored;
      }
    }

    final focusNode = useFocusNode(onKeyEvent: onKeyEvent);
    useOnListenableChange(focusNode, () {
      if (focusNode.hasFocus && activeSelection.value == null) {
        const firstSelection = TextSelection(baseOffset: 0, extentOffset: 1);

        update(value: controller.text.characters, selection: firstSelection);
      }
    });

    void submit(Characters value) {
      controller.text = value.string;
      previous.value = value;
      focusNode.unfocus();
      activeSelection.value = null;
      onCompleted(value.string);
    }

    void rollback() {
      focusNode.unfocus();
      controller.text = previous.value.string;
    }

    void onChanged(String value) {
      if (activeSelection.value == null) {
        return rollback();
      }

      final (normalized, nextSelection) = nextStateFor(
        previous: previous.value,
        current: controller.text.characters,
        previousSelection: activeSelection.value!,
      );
      if (nextSelection == null) {
        return submit(normalized);
      }

      return update(value: normalized, selection: nextSelection);
    }

    void onSelectionChanged(
      TextSelection selection,
      SelectionChangedCause? cause,
    ) {
      final current = controller.text.characters;
      if (activeSelection.value == null || current != previous.value) {
        return;
      }

      if (!selection.isCollapsed) {
        activeSelection.value = selection;

        return;
      }

      final nextSelection = nextSelectionFor(
        previousSelection: activeSelection.value!,
        currentSelection: selection,
        current: current,
      );
      if (nextSelection == null) {
        return submit(current);
      }

      activeSelection.value = nextSelection;
      controller.selection = nextSelection;
    }

    void onTapDigitBox(int index) {
      focusNode.requestFocus();

      final nextSelection = TextSelection(
        baseOffset: index,
        extentOffset: index + 1,
      );

      activeSelection.value = nextSelection;
      controller.selection = nextSelection;
      _showToolbar();
    }

    void selectAllAndShowToolbar(int index) {
      focusNode.requestFocus();

      final nextSelection = TextSelection(
        baseOffset: 0,
        extentOffset: controller.text.characters.length,
      );

      activeSelection.value = nextSelection;
      controller.selection = nextSelection;
      _showToolbar();
    }

    void onDoubleTapDigitBox(int index) => selectAllAndShowToolbar(index);

    void onLongPressDigitBox(int index) => selectAllAndShowToolbar(index);

    void onTapOutsideDigitBox() {
      focusNode.unfocus();
      activeSelection.value = null;
    }

    return Column(
      spacing: Spacing.sm.dp,
      children: [
        Text(l10n.enterVerificationCode, style: context.textTheme.titleMedium),
        AutofillGroup(
          onDisposeAction: AutofillContextAction.cancel,
          child: Form(
            child: Stack(
              alignment: AlignmentGeometry.centerLeft,
              children: [
                Offstage(
                  child: EditableText(
                    key: WidgetKeys.otpEditableText,
                    controller: controller,
                    focusNode: focusNode,
                    style: context.defaultTextStyle,
                    cursorColor: context.colorScheme.primary,
                    backgroundCursorColor: Colors.grey,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onChanged: onChanged,
                    onSelectionChanged: onSelectionChanged,
                    inputFormatters: [
                      TextInputFormatters.digitOrWhitespace,
                    ],
                    selectAllOnFocus: false,
                    autofillHints: const [AutofillHints.oneTimeCode],
                  ),
                ),
                TapRegion(
                  onTapOutside: (_) => onTapOutsideDigitBox(),
                  child: Wrap(
                    spacing: Spacing.xs.dp,
                    alignment: WrapAlignment.spaceEvenly,
                    children: List.generate(
                      length,
                      (index) {
                        final char =
                            controller.text.characters.elementAtOrNull(index) ??
                            placeholderChar.string;
                        final isActive =
                            activeSelection.value?.contains(index) ?? false;

                        return OTPDigitBox(
                          onTap: () => onTapDigitBox(index),
                          onDoubleTap: () => onDoubleTapDigitBox(index),
                          onLongPress: () => onLongPressDigitBox(index),
                          value: char,
                          isActive: isActive,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SelectableText(controller.text),
      ],
    );
  }

  @visibleForTesting
  static (Characters, TextSelection?) nextStateFor({
    required Characters previous,
    required Characters current,
    required TextSelection previousSelection,
  }) {
    final selectionLength =
        (previousSelection.baseOffset - previousSelection.extentOffset).abs();
    final operation = _EditOperation.from(
      previousLength: previous.length,
      currentLength: current.length,
      selectionLength: selectionLength,
    );

    final (selectionStartIndex, selectionEndIndex) = (
      previousSelection.baseOffset,
      previousSelection.extentOffset,
    );
    final lastIndex = previous.length - 1;

    var characters = previous;

    switch (operation) {
      case _EditOperation.delete:
        final isAllBlank = previous
            .skip(selectionStartIndex)
            .take(selectionLength)
            .isAllBlank;
        final nextIndex = isAllBlank
            ? max(0, selectionStartIndex - 1)
            : selectionStartIndex;

        for (
          var index = isAllBlank ? nextIndex : selectionStartIndex;
          index < selectionEndIndex;
          index++
        ) {
          characters = characters.replaceAt(index, placeholderChar);
        }

        return (
          characters,
          TextSelection(baseOffset: nextIndex, extentOffset: nextIndex + 1),
        );

      case _EditOperation.single:
        final inputChar = current.elementAt(selectionStartIndex).characters;

        characters = characters.replaceAt(selectionStartIndex, inputChar);

        if (selectionStartIndex >= lastIndex && !characters.hasBlank) {
          return (characters, null);
        }

        if (selectionLength > 1) {
          for (
            var index = selectionStartIndex + 1;
            index < selectionEndIndex;
            index++
          ) {
            characters = characters.replaceAt(index, placeholderChar);
          }
        }

        final blankIndex = characters.blankIndexOf;
        final nextIndex = selectionStartIndex >= lastIndex && blankIndex != null
            ? blankIndex
            : selectionStartIndex + 1;

        return (
          characters,
          TextSelection(baseOffset: nextIndex, extentOffset: nextIndex + 1),
        );

      case _EditOperation.multiple:
        final pastedCount = (current.length - previous.length + selectionLength)
            .clamp(0, previous.length - selectionStartIndex);
        final pasted = current.skip(selectionStartIndex).take(pastedCount);

        for (var offset = 0; offset < pastedCount; offset++) {
          characters = characters.replaceAt(
            selectionStartIndex + offset,
            pasted.elementAt(offset).characters,
          );
        }

        if (pastedCount < selectionLength) {
          for (
            var index = selectionStartIndex + pastedCount;
            index < selectionEndIndex;
            index++
          ) {
            characters = characters.replaceAt(index, placeholderChar);
          }
        }

        if (!characters.hasBlank) {
          return (characters, null);
        }

        final blankIndex = characters.blankIndexOf!;
        final lastWrittenIndex = selectionStartIndex + pastedCount - 1;
        final nextIndex =
            pastedCount < selectionLength || lastWrittenIndex < lastIndex
            ? selectionStartIndex + pastedCount
            : blankIndex;

        return (
          characters,
          TextSelection(baseOffset: nextIndex, extentOffset: nextIndex + 1),
        );
    }
  }

  @visibleForTesting
  static TextSelection? nextSelectionFor({
    required TextSelection previousSelection,
    required TextSelection currentSelection,
    required Characters current,
  }) {
    assert(!previousSelection.isCollapsed);
    assert(currentSelection.isCollapsed);

    final collapsedOffset = currentSelection.baseOffset;
    if (collapsedOffset == previousSelection.baseOffset) {
      return TextSelection(
        baseOffset: max(0, collapsedOffset - 1),
        extentOffset: max(1, collapsedOffset),
      );
    }
    if (collapsedOffset == previousSelection.extentOffset) {
      final length = current.length;

      if (!current.hasBlank && collapsedOffset == length) {
        return null;
      }

      return TextSelection(
        baseOffset: min(collapsedOffset, length - 1),
        extentOffset: min(collapsedOffset + 1, length),
      );
    }

    throw StateError(
      'currentSelection.baseOffset ($collapsedOffset) is'
      ' out of previousSelection range'
      ' [${previousSelection.baseOffset}, ${previousSelection.extentOffset}]',
    );
  }

  static void _showToolbar() {
    final editableState = WidgetKeys.otpEditableText.currentState;

    if (editableState == null) {
      return;
    }
    editableState.showToolbar();
  }
}

@visibleForTesting
@immutable
class OTPDigitBox extends HookConsumerWidget {
  const OTPDigitBox({
    super.key,
    required this.onTap,
    required this.onDoubleTap,
    required this.onLongPress,
    required this.value,
    required this.isActive,
  });

  final VoidCallback onTap;

  final VoidCallback onDoubleTap;

  final VoidCallback onLongPress;

  final String value;

  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) => GestureDetector(
    onTap: onTap,
    onDoubleTap: onDoubleTap,
    onLongPress: onLongPress,
    child: IntrinsicWidth(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: Spacing.sm.dp,
          horizontal: Spacing.md.dp,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive
                ? context.colorScheme.primary
                : context.colorScheme.outline,
            width: isActive ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(value, style: context.textTheme.titleLarge),
      ),
    ),
  );
}
