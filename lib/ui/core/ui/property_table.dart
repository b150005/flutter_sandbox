import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/config/constants/spacing.dart';
import '../extensions/build_context.dart';
import 'label.dart';

part 'property_table.freezed.dart';

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

@freezed
abstract class PropertyTableCellData with _$PropertyTableCellData {
  const factory PropertyTableCellData({
    Key? key,
    required String label,
    required String value,
    TextStyle? valueStyle,
    Widget? prefix,
    Widget? suffix,
  }) = _PropertyTableCellData;
}
