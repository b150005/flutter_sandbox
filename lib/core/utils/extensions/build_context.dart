import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../ui/core/themes/extensions/status_colors.dart';
import '../../../ui/core/ui/utils/preview/wrapper.dart';
import '../../config/constants/border_radii.dart';
import '../../config/constants/spacing.dart';
import 'theme_data.dart';

@Preview(name: 'TextTheme Table', wrapper: wrapper)
Widget textThemeProperties() => Builder(
  builder: (context) => Table(
    defaultColumnWidth: const IntrinsicColumnWidth(),
    children: [
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: 'Weight',
        fontSizeText: 'Size',
        lineHeightText: 'Line Height',
        letterSpacingText: 'Letter Spacing',
        previewText: 'Preview',
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w400',
        fontSizeText: '57',
        lineHeightText: '64',
        letterSpacingText: '0',
        previewText: '.displayLarge',
        previewTextStyle: context.textTheme.displayLarge,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w400',
        fontSizeText: '45',
        lineHeightText: '52',
        letterSpacingText: '0',
        previewText: '.displayMedium',
        previewTextStyle: context.textTheme.displayMedium,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w400',
        fontSizeText: '36',
        lineHeightText: '44',
        letterSpacingText: '0',
        previewText: '.displaySmall',
        previewTextStyle: context.textTheme.displaySmall,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w400',
        fontSizeText: '32',
        lineHeightText: '40',
        letterSpacingText: '0',
        previewText: '.headlineLarge',
        previewTextStyle: context.textTheme.headlineLarge,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w400',
        fontSizeText: '28',
        lineHeightText: '36',
        letterSpacingText: '0',
        previewText: '.headlineMedium',
        previewTextStyle: context.textTheme.headlineMedium,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w400',
        fontSizeText: '24',
        lineHeightText: '32',
        letterSpacingText: '0',
        previewText: '.headlineSmall',
        previewTextStyle: context.textTheme.headlineSmall,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w500',
        fontSizeText: '22',
        lineHeightText: '28',
        letterSpacingText: '0',
        previewText: '.titleLarge',
        previewTextStyle: context.textTheme.titleLarge,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w500',
        fontSizeText: '16',
        lineHeightText: '24',
        letterSpacingText: '0.15',
        previewText: '.titleMedium',
        previewTextStyle: context.textTheme.titleMedium,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w500',
        fontSizeText: '14',
        lineHeightText: '20',
        letterSpacingText: '0.1',
        previewText: '.titleSmall',
        previewTextStyle: context.textTheme.titleSmall,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w500',
        fontSizeText: '14',
        lineHeightText: '20',
        letterSpacingText: '0.1',
        previewText: '.labelLarge',
        previewTextStyle: context.textTheme.labelLarge,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w500',
        fontSizeText: '12',
        lineHeightText: '16',
        letterSpacingText: '0.5',
        previewText: '.labelMedium',
        previewTextStyle: context.textTheme.labelMedium,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w500',
        fontSizeText: '11',
        lineHeightText: '16',
        letterSpacingText: '0.5',
        previewText: '.labelSmall',
        previewTextStyle: context.textTheme.labelSmall,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w400',
        fontSizeText: '16',
        lineHeightText: '24',
        letterSpacingText: '0.15',
        previewText: '.bodyLarge',
        previewTextStyle: context.textTheme.bodyLarge,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
        fontWeightText: '.w400',
        fontSizeText: '14',
        lineHeightText: '20',
        letterSpacingText: '0.25',
        previewText: '.bodyMedium',
        previewTextStyle: context.textTheme.bodyMedium,
      ),
      _TextThemePreviewTableRowBuilder.fromData(
        context,
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

final class _TextThemePreviewTableRowBuilder {
  const _TextThemePreviewTableRowBuilder._();

  static TableRow fromData(
    BuildContext context, {
    required String fontWeightText,
    required String fontSizeText,
    required String lineHeightText,
    required String letterSpacingText,
    required String previewText,
    TextStyle? previewTextStyle,
  }) {
    final style = context.textTheme.bodyMedium;

    return TableRow(
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(Spacing.xxs.dp),
            child: Align(
              child: Text(
                fontWeightText,
                style: style,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(Spacing.xxs.dp),
            child: Align(
              child: Text(
                fontSizeText,
                style: style,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(Spacing.xxs.dp),
            child: Align(
              child: Text(
                lineHeightText,
                style: style,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(Spacing.xxs.dp),
            child: Align(child: Text(letterSpacingText, style: style)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(Spacing.xxs.dp),
            child: Text(
              previewText,
              style: previewTextStyle ?? style,
            ),
          ),
        ),
      ],
    );
  }
}

extension AppThemeExtension on BuildContext {
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
}

extension BreakpointExtension on BuildContext {
  ResponsiveBreakpointsData get responsiveBreakpoint =>
      ResponsiveBreakpoints.of(this);

  Breakpoint get breakpoint => responsiveBreakpoint.breakpoint;
}

extension WidgetExtension on BuildContext {
  CircularProgressIndicator get loadingIndicator =>
      CircularProgressIndicator.adaptive(
        backgroundColor: colorScheme.onPrimary,
      );
}

extension RouterExtension on BuildContext {
  GoRouterState get routerState => GoRouterState.of(this);

  String get currentPath => routerState.uri.path;

  bool isAt(String path) => currentPath == path;
}
