import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/widget_keys.dart';
import '../../../core/utils/extensions/string.dart';
import '../extensions/build_context.dart';
import 'label.dart';

@immutable
class SearchTextField extends ConsumerWidget {
  const SearchTextField({
    super.key,
    this.labelText,
    required this.controller,
    this.hintText,
  });

  final String? labelText;

  final TextEditingController controller;

  final String? hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textField = TextField(
      key: WidgetKeys.searchTextField,
      controller: controller,
      decoration: context.outlinedInputDecoration.copyWith(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search_outlined),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                onPressed: controller.clear,
                icon: const Icon(Icons.clear_outlined),
              ),
      ),
      textInputAction: .search,
    );

    if (labelText.isNullOrEmpty) {
      return textField;
    }

    return Label(labelText!, child: textField);
  }
}
