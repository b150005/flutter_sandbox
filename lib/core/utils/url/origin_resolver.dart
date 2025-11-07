import '../../config/env/env.dart';

class OriginResolver {
  const OriginResolver._();

  static const int localDevelopmentServerPort = 5500;

  static const String localDevelopmentOrigin =
      'http://localhost:$localDevelopmentServerPort';

  static String get current =>
      kDebugModeInDevOnWeb ? localDevelopmentOrigin : Env.instance.origin;
}
