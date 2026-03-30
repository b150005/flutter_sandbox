import 'package:flutter/material.dart';
import 'package:flutter_sandbox/ui/core/ui/callout.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../testing/golden/golden_test_utils.dart';
import '../../../../../testing/widgets/test_app.dart';

extension _CommonFindersExtension on CommonFinders {
  Finder get callout => byType(Callout);
}

extension _WidgetTesterExtension on WidgetTester {
  Future<void> pumpTestApp({
    String message = 'test message',
    CalloutType? type,
    VoidCallback? onDismiss,
    Widget? child,
  }) => pumpWidget(
    TestApp(
      child: type == null
          ? Callout(
              message,
              onDismiss: onDismiss,
              child: child,
            )
          : Callout(
              message,
              type: type,
              onDismiss: onDismiss,
              child: child,
            ),
    ),
  );
}

void main() {
  testWidgets(
    'Callout should use the info icon for CalloutType.info.',
    (tester) async {
      await tester.pumpTestApp(type: .info);

      await expectLater(
        find.callout,
        matchesGoldenFile(GoldenTestUtils.goldenFile('callout_info.png')),
      );
    },
  );

  testWidgets(
    'Callout should use the check_circle icon for CalloutType.success.',
    (tester) async {
      await tester.pumpTestApp(type: .success);

      await expectLater(
        find.callout,
        matchesGoldenFile(GoldenTestUtils.goldenFile('callout_success.png')),
      );
    },
  );

  testWidgets(
    'Callout should use the warning_amber icon for CalloutType.warning.',
    (tester) async {
      await tester.pumpTestApp(type: .warning);

      await expectLater(
        find.callout,
        matchesGoldenFile(GoldenTestUtils.goldenFile('callout_warning.png')),
      );
    },
  );

  testWidgets(
    'Callout should use the error_outline icon for CalloutType.error.',
    (tester) async {
      await tester.pumpTestApp(type: .error);

      await expectLater(
        find.callout,
        matchesGoldenFile(GoldenTestUtils.goldenFile('callout_error.png')),
      );
    },
  );
}
