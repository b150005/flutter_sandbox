import 'package:flutter/material.dart';

import 'app_initializer.dart';

final class AppInitializerImpl extends AppInitializerProtocol {
  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await super.initializeFirebaseApp();
  }
}
