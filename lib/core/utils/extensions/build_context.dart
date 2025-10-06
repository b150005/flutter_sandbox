import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../ui/core/themes/extensions/status_colors.dart';
import 'theme_data.dart';

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

  ResponsiveBreakpointsData get responsiveBreakpointsData =>
      ResponsiveBreakpoints.of(this);

  Breakpoint get breakpoint => responsiveBreakpointsData.breakpoint;
}
