import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../core/config/constants/spacing.dart';
import '../../../core/utils/extensions/build_context.dart';
import 'label.dart';
import 'utils/preview/wrapper.dart';

@Preview(name: 'Property Table', wrapper: wrapper)
Widget propertyTable() => PropertyTable(
  cellData: const [
    PropertyTableCellData(label: 'key 1', value: 'value 1'),
    PropertyTableCellData(
      label: 'key 2',
      value: 'value 2',
      prefix: Icon(Icons.check_outlined),
    ),
    PropertyTableCellData(
      label: 'key 3',
      value: 'value 3',
      suffix: Icon(Icons.check_outlined),
    ),
    PropertyTableCellData(
      label: 'key 4',
      value: 'value 4',
      prefix: Icon(Icons.check_outlined),
      suffix: Icon(Icons.check_outlined),
    ),
    PropertyTableCellData(label: 'key 5', value: 'value 5'),
  ],
  columnCount: 2,
);

@immutable
class PropertyTable extends StatelessWidget {
  const PropertyTable({
    super.key,
    required this.cellData,
    this.columnCount = 1,
    this.columnWidths,
    this.defaultColumnWidth = const FlexColumnWidth(),
    this.textDirection,
    this.border,
    this.defaultVerticalAlignment = TableCellVerticalAlignment.top,
    this.textBaseline,
  }) : assert(cellData.length > 0, 'data cannot be empty.'),
       assert(columnCount > 0, 'columnCount must be positive.');

  final List<PropertyTableCellData> cellData;
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
    children: cellData.indexed
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
                      final current = cellData.elementAtOrNull(index);

                      return acc..add(
                        _PropertyTableCell(
                          data: current,
                        ),
                      );
                    }),
              ),
            ),
        ),
  );
}

@immutable
class _PropertyTableCell extends StatelessWidget {
  const _PropertyTableCell({this.data});

  final PropertyTableCellData? data;

  @override
  Widget build(BuildContext context) => data == null
      ? const SizedBox.shrink()
      : Label(
          key: data!.key,
          data!.label,
          child: Row(
            spacing: Spacing.xs.dp,
            children: [
              ?data!.prefix,
              Flexible(
                child: Text(
                  data!.value,
                  style: data!.valueStyle ?? context.textTheme.bodyMedium,
                ),
              ),
              ?data!.suffix,
            ],
          ),
        );
}

@immutable
class PropertyTableCellData {
  const PropertyTableCellData({
    this.key,
    required this.label,
    required this.value,
    this.valueStyle,
    this.prefix,
    this.suffix,
  });

  final Key? key;
  final String label;
  final String value;
  final TextStyle? valueStyle;
  final Widget? prefix;
  final Widget? suffix;
}
