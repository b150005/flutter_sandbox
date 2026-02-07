import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/spacing.dart';
import '../../../core/config/constants/widget_keys.dart';
import '../../../core/utils/l10n/app_localizations.dart';
import '../extensions/build_context.dart';
import '../extensions/navigator_state.dart';
import '../hooks/use_debounced_text_editing_controller.dart';

typedef ItemBuilder<T> = Widget? Function(T item);

abstract final class AppDialogs {
  const AppDialogs._();

  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    Key? key,
    IconData? icon,
    Widget? title,
    required String content,
    String? cancelLabel,
    String? confirmLabel,
    ButtonStyle? confirmButtonStyle,
    bool barrierDismissible = true,
  }) => showAdaptiveDialog<bool>(
    context: context,
    builder: (context) => _ConfirmationDialog(
      key: key,
      icon: icon,
      title: title,
      content: content,
      cancelLabel: cancelLabel,
      confirmLabel: confirmLabel,
      confirmButtonStyle: confirmButtonStyle,
    ),
    barrierDismissible: barrierDismissible,
    barrierLabel: context.modalBarrierDismissLabel,
  );

  static Future<T?> showSearchableListDialog<T>({
    required BuildContext context,
    Key? key,
    Widget? title,
    String? searchHintText,
    bool showCloseButton = true,
    required List<T> items,
    ItemBuilder<T>? itemLeadingBuilder,
    ItemBuilder<T>? itemTitleBuilder,
    ItemBuilder<T>? itemSubtitleBuilder,
    ItemBuilder<T>? itemTrailingBuilder,
    T? initialSelection,
    bool Function(T item, String query)? searchFilter,
    Duration timeout = const Duration(milliseconds: 300),
    bool barrierDismissible = true,
  }) => showAdaptiveDialog(
    context: context,
    builder: (context) => _SearchableListDialog(
      key: key,
      title: title,
      searchHintText: searchHintText,
      showCloseButton: showCloseButton,
      items: items,
      itemLeadingBuilder: itemLeadingBuilder,
      itemTitleBuilder: itemTitleBuilder,
      itemSubtitleBuilder: itemSubtitleBuilder,
      itemTrailingBuilder: itemTrailingBuilder,
      initialSelection: initialSelection == null
          ? <T>{}
          : Set.of({initialSelection}),
      searchFilter: searchFilter,
      timeout: timeout,
    ),
    barrierDismissible: barrierDismissible,
    barrierLabel: context.modalBarrierDismissLabel,
  );

  static Future<Set<T>?> showMultiSelectableListDialog<T>({
    required BuildContext context,
    Key? key,
    Widget? title,
    String? searchHintText,
    bool showCloseButton = true,
    required List<T> items,
    ItemBuilder<T>? itemLeadingBuilder,
    ItemBuilder<T>? itemTitleBuilder,
    ItemBuilder<T>? itemSubtitleBuilder,
    ItemBuilder<T>? itemTrailingBuilder,
    required Set<T> initialSelection,
    bool Function(T item, String query)? searchFilter,
    Duration timeout = const Duration(milliseconds: 300),
    required String Function(T item)? chipLabel,
    bool barrierDismissible = true,
  }) => showAdaptiveDialog(
    context: context,
    builder: (context) => _SearchableListDialog(
      key: key,
      title: title,
      searchHintText: searchHintText,
      showCloseButton: showCloseButton,
      items: items,
      itemLeadingBuilder: itemLeadingBuilder,
      itemTitleBuilder: itemTitleBuilder,
      itemSubtitleBuilder: itemSubtitleBuilder,
      itemTrailingBuilder: itemTrailingBuilder,
      initialSelection: initialSelection,
      searchFilter: searchFilter,
      timeout: timeout,
      multiSelectable: true,
      chipLabel: chipLabel,
    ),
    barrierDismissible: barrierDismissible,
    barrierLabel: context.modalBarrierDismissLabel,
  );
}

@immutable
class _ConfirmationDialog extends ConsumerWidget {
  const _ConfirmationDialog({
    super.key,
    this.icon,
    this.title,
    required this.content,
    this.cancelLabel,
    this.confirmButtonStyle,
    this.confirmLabel,
  });

  final IconData? icon;
  final Widget? title;
  final String content;
  final String? cancelLabel;
  final ButtonStyle? confirmButtonStyle;
  final String? confirmLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return SelectionArea(
      child: AlertDialog(
        key: WidgetKeys.confirmationDialog,
        icon: icon == null ? null : Icon(icon),
        title: title,
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => context.rootNavigator.safePop(false),
            child: Text(cancelLabel ?? l10n.cancel),
          ),
          FilledButton(
            onPressed: () => context.rootNavigator.safePop(true),
            style: confirmButtonStyle,
            child: Text(confirmLabel ?? l10n.confirm),
          ),
        ],
      ),
    );
  }
}

@immutable
class _SearchableListDialog<T> extends HookConsumerWidget {
  const _SearchableListDialog({
    super.key,
    required this.showCloseButton,
    required this.items,
    this.itemLeadingBuilder,
    this.itemTitleBuilder,
    this.itemSubtitleBuilder,
    this.itemTrailingBuilder,
    required this.initialSelection,
    this.title,
    required this.timeout,
    this.searchFilter,
    this.searchHintText,
    this.multiSelectable = false,
    this.chipLabel,
  }) : assert(!multiSelectable || multiSelectable && chipLabel != null);

  final bool showCloseButton;

  final List<T> items;

  final ItemBuilder<T>? itemLeadingBuilder;

  final ItemBuilder<T>? itemTitleBuilder;

  final ItemBuilder<T>? itemSubtitleBuilder;

  final ItemBuilder<T>? itemTrailingBuilder;

  final Set<T> initialSelection;

  final Widget? title;

  final Duration timeout;

  final bool Function(T item, String query)? searchFilter;

  final String? searchHintText;

  final String Function(T item)? chipLabel;

  final bool multiSelectable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final filteredItems = useState<List<T>>(items);
    final selectedItems = useState<Set<T>>(initialSelection);

    void onQueryChanged(String value) {
      if (searchFilter == null) {
        return;
      }

      final query = value.toLowerCase();

      if (query.isEmpty) {
        filteredItems.value = items;

        return;
      }

      filteredItems.value = items
          .where((item) => searchFilter!(item, query))
          .toList();
    }

    final controller = useDebouncedTextEditingController(
      onDebounced: onQueryChanged,
      timeout: timeout,
    );

    void onItemTapped(T item) {
      if (!multiSelectable) {
        context.rootNavigator.safePop(item);

        return;
      }

      // FIXME(b150005): もしこれで更新されないなら Set.union, Set.difference を使う
      if (selectedItems.value.contains(item)) {
        selectedItems.value.remove(item);

        return;
      }

      selectedItems.value.add(item);
    }

    return AlertDialog(
      key: WidgetKeys.searchableListDialog,
      title: title,
      content: SizedBox(
        width: context.windowSize.width * 0.7,
        height: context.windowSize.height * 0.7,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: Spacing.sm.dp,
                children: [
                  if (searchFilter != null)
                    Flexible(
                      // TODO(b150005): この TextField の共通化
                      child: TextField(
                        controller: controller,
                        decoration: context.outlinedInputDecoration.copyWith(
                          hintText: searchHintText,
                          prefixIcon: const Icon(Icons.search_outlined),
                          suffixIcon: controller.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: controller.clear,
                                  icon: const Icon(Icons.clear_outlined),
                                ),
                        ),
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                  if (multiSelectable)
                    TextButton(
                      onPressed: () =>
                          context.rootNavigator.safePop(selectedItems.value),
                      child: Text(l10n.done),
                    ),
                  if (showCloseButton)
                    IconButton(
                      onPressed: () => context.rootNavigator.safePop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                ],
              ),
            ),
            if (multiSelectable && selectedItems.value.isNotEmpty)
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: selectedItems.value
                        .map(
                          (selectedItem) => InputChip(
                            label: Text(chipLabel!(selectedItem)),
                            onDeleted: () =>
                                selectedItems.value.remove(selectedItem),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            SliverList.builder(
              itemCount: filteredItems.value.length,
              itemBuilder: (context, index) {
                final item = filteredItems.value[index];
                final isSelected = selectedItems.value.contains(item);

                return ListTile(
                  leading: itemLeadingBuilder?.call(item),
                  title: itemTitleBuilder?.call(item),
                  subtitle: itemSubtitleBuilder?.call(item),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: Spacing.sm.dp,
                    children: [
                      ?itemTrailingBuilder?.call(item),
                      if (multiSelectable)
                        Icon(
                          isSelected
                              ? Icons.check_circle_rounded
                              : Icons.circle_outlined,
                        ),
                    ],
                  ),
                  onTap: () => onItemTapped(item),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
