import 'app_initializer.dart';

final class AppInitializerImpl extends AppInitializerProtocol {
  @override
  Future<void> initialize() {
    super.initializeErrorHandlers();

    throw UnsupportedError('AppInitializer is not supported on this platform.');
  }
}
