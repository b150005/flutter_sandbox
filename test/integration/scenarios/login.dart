import 'package:flutter_sandbox/core/config/initialization/app_initializer.dart';
import 'package:flutter_sandbox/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await AppInitializer.instance.initialize();
  });

  group('', () {
    // TODO(b150005): アプリの起動 → ログインフォームの表示
    testWidgets('', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
    });

    // TODO(b150005): 正常なログインフロー
    testWidgets('', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
    });

    // TODO(b150005): 無効なログインフロー
    testWidgets('', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
    });

    // TODO(b150005): パスワードリセット
    testWidgets('', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
    });

    // TODO(b150005): パスワードリセット
    testWidgets('', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
    });

    // TODO(b150005): 文字サイズ
    testWidgets('', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
    });

    // TODO(b150005): 画面開店時の表示・状態保持
    testWidgets('', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
    });

    // TODO(b150005): アプリの再起動
    testWidgets('', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
    });
  });
}
