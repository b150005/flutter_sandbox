import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../capabilities/package_capability.dart';
import '../constants/window_size.dart';
import 'app_initializer.dart';

final class AppInitializerImpl extends AppInitializerProtocol {
  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    super.initializeErrorHandlers();

    await super.initializeFirebaseApp();

    if (PackageCapability.supportsWindowManager) {
      await windowManager.ensureInitialized();

      final windowOptions = WindowOptions(minimumSize: WindowSize.min.size);
      await windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }
}
