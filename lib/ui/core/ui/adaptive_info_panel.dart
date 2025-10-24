import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/config/constants/spacing.dart';
import '../../../core/utils/extensions/build_context.dart';
import '../../../core/utils/extensions/string.dart';
import 'utils/preview/wrapper.dart';

@Preview(name: 'Adaptive Info Panel', wrapper: wrapper)
Widget adaptiveInfoPanel() => Card.outlined(
  child: Padding(
    padding: EdgeInsets.all(Spacing.sm.dp),
    child: AdaptiveInfoPanel(
      entries: const [
        MapEntry('key 1', 'value 1'),
        MapEntry('key 2', 'value 2'),
        MapEntry('key 3', 'value 3'),
        MapEntry('key 4', 'value 4'),
        MapEntry('key 5', 'value 5'),
      ],
      columnCount: 3,
    ),
  ),
);

@immutable
class AdaptiveInfoPanel extends StatelessWidget {
  const AdaptiveInfoPanel({
    super.key,
    required this.entries,
    this.columnCount = 2,
    this.columnWidths,
    this.defaultColumnWidth = const FlexColumnWidth(),
    this.textDirection,
    this.border,
    this.defaultVerticalAlignment = TableCellVerticalAlignment.top,
    this.textBaseline,
  }) : assert(entries.length > 0, 'entries cannot be empty.'),
       assert(columnCount > 0, 'columnCount must be positive.');

  final List<MapEntry<String, String>> entries;
  final int columnCount;
  final Map<int, TableColumnWidth>? columnWidths;
  final TableColumnWidth defaultColumnWidth;
  final TextDirection? textDirection;
  final TableBorder? border;
  final TableCellVerticalAlignment defaultVerticalAlignment;
  final TextBaseline? textBaseline;

  @override
  Widget build(BuildContext context) =>
      context.responsiveBreakpoint.smallerOrEqualTo(MOBILE)
      ? Column(
          key: key,
          spacing: Spacing.sm.dp,
          children: entries
              .map(
                (entry) => Column(
                  spacing: Spacing.sm.dp,
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(color: context.colorScheme.outline),
                    ),
                    Text(entry.value),
                  ],
                ),
              )
              .toList(),
        )
      : _AdaptiveInfoTable(
          key: key,
          entries: entries,
          columnCount: entries.length == 1 ? entries.length : columnCount,
          columnWidths: columnWidths,
          defaultColumnWidth: defaultColumnWidth,
          textDirection: textDirection,
          border: border,
          defaultVerticalAlignment: defaultVerticalAlignment,
          textBaseline: textBaseline,
        );
}

@immutable
class _AdaptiveInfoTable extends StatelessWidget {
  const _AdaptiveInfoTable({
    super.key,
    required this.entries,
    required this.columnCount,
    required this.columnWidths,
    required this.defaultColumnWidth,
    required this.textDirection,
    required this.border,
    required this.defaultVerticalAlignment,
    required this.textBaseline,
  });

  final List<MapEntry<String, String>> entries;
  final int columnCount;
  final Map<int, TableColumnWidth>? columnWidths;
  final TableColumnWidth defaultColumnWidth;
  final TextDirection? textDirection;
  final TableBorder? border;
  final TableCellVerticalAlignment defaultVerticalAlignment;
  final TextBaseline? textBaseline;

  @override
  Widget build(BuildContext context) => Table(
    key: key,
    columnWidths: columnWidths,
    defaultColumnWidth: defaultColumnWidth,
    textDirection: textDirection,
    border: border,
    defaultVerticalAlignment: defaultVerticalAlignment,
    textBaseline: textBaseline,
    children: entries.indexed
        .where((record) => record.$1 % columnCount == 0)
        .fold<List<TableRow>>(
          [],
          (acc, record) => acc
            ..add(
              TableRow(
                children:
                    List.generate(
                      columnCount,
                      (i) => record.$1 + i,
                    ).fold<List<Widget>>([], (acc, index) {
                      final current = entries.elementAtOrNull(index);

                      acc.addAll([
                        _AdaptiveInfoTableLabelCell(
                          text: current?.key,
                        ),
                        _AdaptiveInfoTableValueCell(
                          text: current?.value,
                        ),
                      ]);

                      return acc;
                    }),
              ),
            ),
        ),
  );
}

@immutable
class _AdaptiveInfoTableLabelCell extends StatelessWidget {
  const _AdaptiveInfoTableLabelCell({
    this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) => text.isNullOrEmpty
      ? const SizedBox.shrink()
      : TableCell(
          child: Text(
            text!,
            style: TextStyle(color: context.colorScheme.outline),
          ),
        );
}

@immutable
class _AdaptiveInfoTableValueCell extends StatelessWidget {
  const _AdaptiveInfoTableValueCell({
    this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) => text.isNullOrEmpty
      ? const SizedBox.shrink()
      : TableCell(
          child: Text(
            text!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
}
