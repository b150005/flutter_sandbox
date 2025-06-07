import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

enum NavigationLayout { bar, rail }

final class DesignPolicy {
  const DesignPolicy._();

  static bool get shouldUseCupertino => switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => true,
    _ => false,
  };

  static NavigationLayout chooseNavigationLayout(BuildContext context) =>
      switch (ResponsiveBreakpoints.of(context).breakpoint.name) {
        null || MOBILE => NavigationLayout.bar,
        TABLET || DESKTOP => NavigationLayout.rail,
        _ => throw UnsupportedError(
          'Unsupported breakpoint:'
          ' ${ResponsiveBreakpoints.of(context).breakpoint}',
        ),
      };
}
