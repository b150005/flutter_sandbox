import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../ui/core/extensions/build_context.dart';

enum NavigationLayout { bar, rail }

final class DesignPolicy {
  const DesignPolicy._();

  static bool get shouldUseCupertino => switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => true,
    _ => false,
  };

  static NavigationLayout chooseNavigationLayout(BuildContext context) =>
      switch (context.breakpoint.name) {
        null || MOBILE => NavigationLayout.bar,
        TABLET || DESKTOP => NavigationLayout.rail,
        _ => throw UnsupportedError(
          'Unsupported breakpoint: ${context.breakpoint}',
        ),
      };
}
