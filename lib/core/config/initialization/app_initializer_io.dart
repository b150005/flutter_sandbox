import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../capabilities/window.dart';
import '../constants/sizes.dart';
import 'app_initializer.dart';

final class AppInitializerImpl extends AppInitializerProtocol {
  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await super.initializeFirebaseApp();

    if (WindowCapability.supportsWindowManager) {
      await windowManager.ensureInitialized();

      final windowOptions = WindowOptions(minimumSize: Sizes.window.minSize);
      await windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }
}
