import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../main.dart';
import '../../../extensions/build_context.dart';
import '../../../themes/extensions/status_colors.dart';

Widget wrapper(Widget child) => MaterialApp(
  home: ResponsiveBreakpoints.builder(
    child: Builder(
      builder: (context) =>
          ColoredBox(color: context.colorScheme.surface, child: child),
    ),
    breakpoints: App.breakpoints,
  ),
  theme: ThemeData.light(
    useMaterial3: true,
  ).copyWith(extensions: [StatusColors.fromSeed()]),
  darkTheme: ThemeData.dark(
    useMaterial3: true,
  ).copyWith(extensions: [StatusColors.fromSeed(brightness: Brightness.dark)]),
  debugShowCheckedModeBanner: false,
);
