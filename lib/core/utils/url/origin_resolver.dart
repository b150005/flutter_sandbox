import 'package:flutter/foundation.dart';

import '../../config/env/env.dart';

class OriginResolver {
  const OriginResolver._();

  static const int localDevelopmentServerPort = 5500;

  static const String localDevelopmentOrigin =
      'http://localhost:$localDevelopmentServerPort';

  static String get current =>
      isLocalWebDevelopment ? localDevelopmentOrigin : Env.instance.origin;

  static bool get isLocalWebDevelopment => kIsDev && kDebugMode && kIsWeb;
}
