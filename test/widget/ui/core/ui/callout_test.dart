import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_sandbox/ui/core/ui/callout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  Widget callout({
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

  final iconKeyFinder = find.byKey(WidgetKeys.icon);
  final messageKeyFinder = find.byKey(WidgetKeys.message);
  final dismissKeyFinder = find.byKey(WidgetKeys.dismiss);

  const message = 'test message';

  group('🎨 UI elements', () {
    testWidgets(
      'Callout has an icon, message, and dismiss button'
      ' when canDismiss is true.',
      (tester) async {
        await tester.pumpWidget(callout(message: message));

        expect(iconKeyFinder, findsOneWidget);
        expect(messageKeyFinder, findsOneWidget);
        expect(dismissKeyFinder, findsOneWidget);
      },
    );

    testWidgets('Callout has an icon and message when canDismiss is false.', (
      tester,
    ) async {
      await tester.pumpWidget(callout(message: message, canDismiss: false));

      expect(iconKeyFinder, findsOneWidget);
      expect(messageKeyFinder, findsOneWidget);
      expect(dismissKeyFinder, findsNothing);
    });
  });

  group('👆 User interaction', () {
    testWidgets(
      'onDismiss is called when dismiss button is tapped.',
      (tester) async {
        var dismissed = false;

        await tester.pumpWidget(
          callout(
            message: message,
            onDismiss: () => dismissed = true,
          ),
        );

        await tester.tap(dismissKeyFinder);

        expect(dismissed, isTrue);
      },
    );
  });

  group('⚠️ Error handling', () {
    testWidgets('No error occurs when onDismiss is null', (tester) async {
      await tester.pumpWidget(callout(message: message));

      await tester.tap(dismissKeyFinder);
      await tester.pump();
    });
  });

  group('♿️ Accessibility', () {});

  group('⚡️ Performance', () {});
}
