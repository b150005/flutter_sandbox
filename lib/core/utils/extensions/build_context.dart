import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

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

  ResponsiveBreakpointsData get responsiveBreakpointsData =>
      ResponsiveBreakpoints.of(this);

  Breakpoint get breakpoint => responsiveBreakpointsData.breakpoint;
}
