import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../ui/core/themes/extensions/status_colors.dart';
import '../../config/constants/border_radii.dart';
import '../../config/constants/spacing.dart';
import 'theme_data.dart';

@Preview(name: 'TextTheme Table')
Widget textThemeProperties() => Builder(
  builder: (context) => Table(
    defaultColumnWidth: const IntrinsicColumnWidth(),
    children: [
      _textThemePreviewTableRow(
        fontWeightText: 'Weight',
        fontSizeText: 'Size',
        lineHeightText: 'Line Height',
        letterSpacingText: 'Letter Spacing',
        previewText: 'Preview',
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w400',
        fontSizeText: '57',
        lineHeightText: '64',
        letterSpacingText: '0',
        previewText: '.displayLarge',
        previewTextStyle: context.textTheme.displayLarge,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w400',
        fontSizeText: '45',
        lineHeightText: '52',
        letterSpacingText: '0',
        previewText: '.displayMedium',
        previewTextStyle: context.textTheme.displayMedium,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w400',
        fontSizeText: '36',
        lineHeightText: '44',
        letterSpacingText: '0',
        previewText: '.displaySmall',
        previewTextStyle: context.textTheme.displaySmall,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w400',
        fontSizeText: '32',
        lineHeightText: '40',
        letterSpacingText: '0',
        previewText: '.headlineLarge',
        previewTextStyle: context.textTheme.headlineLarge,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w400',
        fontSizeText: '28',
        lineHeightText: '36',
        letterSpacingText: '0',
        previewText: '.headlineMedium',
        previewTextStyle: context.textTheme.headlineMedium,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w400',
        fontSizeText: '24',
        lineHeightText: '32',
        letterSpacingText: '0',
        previewText: '.headlineSmall',
        previewTextStyle: context.textTheme.headlineSmall,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w500',
        fontSizeText: '22',
        lineHeightText: '28',
        letterSpacingText: '0',
        previewText: '.titleLarge',
        previewTextStyle: context.textTheme.titleLarge,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w500',
        fontSizeText: '16',
        lineHeightText: '24',
        letterSpacingText: '0.15',
        previewText: '.titleMedium',
        previewTextStyle: context.textTheme.titleMedium,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w500',
        fontSizeText: '14',
        lineHeightText: '20',
        letterSpacingText: '0.1',
        previewText: '.titleSmall',
        previewTextStyle: context.textTheme.titleSmall,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w500',
        fontSizeText: '14',
        lineHeightText: '20',
        letterSpacingText: '0.1',
        previewText: '.labelLarge',
        previewTextStyle: context.textTheme.labelLarge,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w500',
        fontSizeText: '12',
        lineHeightText: '16',
        letterSpacingText: '0.5',
        previewText: '.labelMedium',
        previewTextStyle: context.textTheme.labelMedium,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w500',
        fontSizeText: '11',
        lineHeightText: '16',
        letterSpacingText: '0.5',
        previewText: '.labelSmall',
        previewTextStyle: context.textTheme.labelSmall,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w400',
        fontSizeText: '16',
        lineHeightText: '24',
        letterSpacingText: '0.15',
        previewText: '.bodyLarge',
        previewTextStyle: context.textTheme.bodyLarge,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w400',
        fontSizeText: '14',
        lineHeightText: '20',
        letterSpacingText: '0.25',
        previewText: '.bodyMedium',
        previewTextStyle: context.textTheme.bodyMedium,
      ),
      _textThemePreviewTableRow(
        fontWeightText: '.w400',
        fontSizeText: '12',
        lineHeightText: '16',
        letterSpacingText: '0.4',
        previewText: '.bodySmall',
        previewTextStyle: context.textTheme.bodySmall,
      ),
    ],
  ),
);

TableRow _textThemePreviewTableRow({
  required String fontWeightText,
  required String fontSizeText,
  required String lineHeightText,
  required String letterSpacingText,
  required String previewText,
  TextStyle? previewTextStyle,
}) => TableRow(
  children: [
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.all(Spacing.xxs.dp),
        child: Align(child: Text(fontWeightText)),
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.all(Spacing.xxs.dp),
        child: Align(child: Text(fontSizeText)),
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.all(Spacing.xxs.dp),
        child: Align(child: Text(lineHeightText)),
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.all(Spacing.xxs.dp),
        child: Align(child: Text(letterSpacingText)),
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.all(Spacing.xxs.dp),
        child: Text(
          previewText,
          style: previewTextStyle,
        ),
      ),
    ),
  ],
);

extension BuildContextExtension on BuildContext {
  @Deprecated(
    'Use specific getters like textTheme, colorScheme instead'
    ' for better code clarity and type safety.',
  )
  ThemeData get theme => Theme.of(this);

  // ignore: deprecated_member_use_from_same_package
  TextTheme get textTheme => theme.textTheme;

  // ignore: deprecated_member_use_from_same_package
  ColorScheme get colorScheme => theme.colorScheme;

  // ignore: deprecated_member_use_from_same_package
  StatusColors get statusColors => theme.statusColors;

  TextStyle get defaultTextStyle => DefaultTextStyle.of(this).style;

  TextStyle? get supportTextStyle =>
      textTheme.bodyMedium?.copyWith(color: colorScheme.outline);

  InputDecoration get outlinedInputDecoration => InputDecoration(
    hintStyle: supportTextStyle,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(BorderRadii.md.value),
    ),
  );

  ResponsiveBreakpointsData get responsiveBreakpoint =>
      ResponsiveBreakpoints.of(this);

  Breakpoint get breakpoint => responsiveBreakpoint.breakpoint;
}
