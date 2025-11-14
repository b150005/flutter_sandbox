import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'app_initializer.dart';

final class AppInitializerImpl extends AppInitializerProtocol {
  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    super.initializeErrorHandlers();

    usePathUrlStrategy();

    await super.initializeFirebaseApp();
  }
}
