import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

TextEditingController useDebouncedTextEditingController({
  String? text,
  List<Object?>? keys,
  ValueChanged<String>? onDebounced,
  Duration timeout = const Duration(milliseconds: 300),
}) {
  final controller = useTextEditingController(text: text, keys: keys);
  final currentText = useListenableSelector(controller, () => controller.text);
  final debouncedText = useDebounced(
    currentText,
    timeout,
  );

  useEffect(() {
    if (text != null) {
      onDebounced?.call(text);
    }

    return null;
  }, const []);

  useValueChanged<String?, void>(debouncedText, (_, _) {
    if (debouncedText == null) {
      return;
    }

    onDebounced?.call(debouncedText);
  });

  return controller;
}
