import 'package:flutter/foundation.dart';

@visibleForTesting
abstract final class GoldenTestUtils {
  const GoldenTestUtils._();

  static String goldenFile(String filename) => 'goldens/$filename';
}
