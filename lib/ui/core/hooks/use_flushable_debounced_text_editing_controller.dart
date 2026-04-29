import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/config/constants/durations.dart';

@immutable
class DebouncedTextFieldManager {
  const DebouncedTextFieldManager({
    required this.controller,
    required this.flush,
  });

  final TextEditingController controller;

  final VoidCallback flush;
}

DebouncedTextFieldManager useFlushableDebouncedTextEditingController({
  String? text,
  List<Object?>? keys,
  ValueChanged<String>? onDebounced,
  Duration timeout = kDefaultDebounceTimeout,
}) {
  final controller = useTextEditingController(text: text, keys: keys);
  final currentText = useListenableSelector(controller, () => controller.text);
  final debouncedText = useDebounced(currentText, timeout);

  final skipNextDebounceRef = useRef<bool>(false);

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

    if (skipNextDebounceRef.value) {
      skipNextDebounceRef.value = false;
      return;
    }

    Future.microtask(() {
      onDebounced?.call(debouncedText);
    });
  });

  void flush() {
    skipNextDebounceRef.value = true;

    onDebounced?.call(currentText);
  }

  return DebouncedTextFieldManager(controller: controller, flush: flush);
}
