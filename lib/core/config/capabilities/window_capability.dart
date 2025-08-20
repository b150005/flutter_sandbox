import 'package:flutter/foundation.dart';

final class WindowCapability {
  const WindowCapability._();

  static bool get supportsWindowManager => switch (defaultTargetPlatform) {
    TargetPlatform.linux ||
    TargetPlatform.macOS ||
    TargetPlatform.windows => true,
    _ => false,
  };
}
