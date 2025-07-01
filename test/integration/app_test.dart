import 'package:flutter_sandbox/core/config/initialization/app_initializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await AppInitializer.instance.initialize();
  });
}
