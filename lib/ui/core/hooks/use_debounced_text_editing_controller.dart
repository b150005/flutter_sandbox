import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/config/constants/durations.dart';

TextEditingController useDebouncedTextEditingController({
  String? text,
  List<Object?>? keys,
  ValueChanged<String>? onDebounced,
  Duration timeout = kDefaultDebounceTimeout,
}) {
  final controller = useTextEditingController(text: text, keys: keys);
  final currentText = useListenableSelector(controller, () => controller.text);
  final debouncedText = useDebounced(
    currentText,
    timeout,
  );

  useValueChanged<String?, void>(debouncedText, (_, _) {
    if (debouncedText == null) {
      return;
    }

    onDebounced?.call(debouncedText);
  });

  return controller;
}
