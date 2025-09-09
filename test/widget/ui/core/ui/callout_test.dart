import 'package:flutter/material.dart';
import 'package:flutter_sandbox/ui/core/ui/callout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../testing/utils/widget_key_finder.dart';

void main() {
  Widget calloutApp({
    required String message,
    CalloutType type = CalloutType.info,
    bool canDismiss = true,
    VoidCallback? onDismiss,
  }) => ProviderScope(
    child: MaterialApp(
      home: Scaffold(
        body: Callout(
          message,
          type: type,
          canDismiss: canDismiss,
          onDismiss: onDismiss,
        ),
      ),
    ),
  );

  const message = 'test message';

  group('🎨 UI elements', () {
    testWidgets(
      'Callout should have an icon, message, and dismiss button.'
      ' when canDismiss is true.',
      (tester) async {
        await tester.pumpWidget(calloutApp(message: message));

        expect(WidgetKeyFinder.icon, findsOneWidget);
        expect(WidgetKeyFinder.message, findsOneWidget);
        expect(WidgetKeyFinder.dismiss, findsOneWidget);
      },
    );

    testWidgets(
      'Callout should have an icon and message when canDismiss is false.',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          calloutApp(message: message, canDismiss: false),
        );

        expect(WidgetKeyFinder.icon, findsOneWidget);
        expect(WidgetKeyFinder.message, findsOneWidget);
        expect(WidgetKeyFinder.dismiss, findsNothing);
      },
    );
  });

  group('👆 User interaction', () {
    testWidgets(
      'onDismiss should be called when dismiss button is tapped.',
      (tester) async {
        var dismissed = false;

        await tester.pumpWidget(
          calloutApp(
            message: message,
            onDismiss: () => dismissed = true,
          ),
        );

        await tester.tap(WidgetKeyFinder.dismiss);

        expect(dismissed, isTrue);
      },
    );
  });

  group('⚠️ Error handling', () {
    testWidgets('No error should occurs when onDismiss is null.', (
      tester,
    ) async {
      await tester.pumpWidget(calloutApp(message: message));

      await tester.tap(WidgetKeyFinder.dismiss);
      await tester.pump();
    });
  });

  group('♿️ Accessibility', () {});

  group('⚡️ Performance', () {});
}
