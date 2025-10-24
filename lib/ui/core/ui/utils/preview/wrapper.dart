import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../main.dart';
import '../../../themes/extensions/status_colors.dart';

Widget wrapper(Widget child) => MaterialApp(
  home: ResponsiveBreakpoints.builder(
    child: child,
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
