import 'dart:async';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  await testMain();
}

/// @see [Including Fonts](https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html)
Future<void> loadAppFonts() async {
  // NOTE(b150005): カスタムフォントはプラットフォーム, Flutter バージョンによって表示が異なるため使用しない
}
