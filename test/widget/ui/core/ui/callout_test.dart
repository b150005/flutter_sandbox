import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_sandbox/ui/core/ui/callout.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../testing/fixtures/lorem_ipsum.dart';
import '../../../../../testing/utils/app_localization_utils.dart';
import '../../../../../testing/utils/widgets/test_app.dart';

extension _CommonFindersExtension on CommonFinders {
  Finder get callout => byType(Callout);

  Finder get icon => byWidgetPredicate(
    (widget) => widget is Icon && widget.key == WidgetKeys.icon,
  );

  Finder get message => byWidgetPredicate(
    (widget) => widget is Text && widget.key == WidgetKeys.message,
  );

  Finder get dismiss => byWidgetPredicate(
    (widget) => widget is IconButton && widget.key == WidgetKeys.dismiss,
  );
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

  Callout get callout => widget<Callout>(find.callout);

  Icon get icon => widget<Icon>(find.icon);
}

extension _UserInteraction on WidgetTester {
  Future<void> tapDismiss() async {
    await tap(find.dismiss);
    await pump();
  }

  Future<void> tapCalloutBody() async {
    await tap(find.byType(Text));
    await pump();
  }
}

void main() {
  final l10n = AppLocalizationUtils.en;

  group('🎨 UI Structure', () {
    testWidgets(
      'Callout should not display a dismiss button when onDismiss is null.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.dismiss, findsNothing);
      },
    );

    testWidgets(
      'Callout should display a dismiss button when onDismiss is provided.',
      (tester) async {
        await tester.pumpTestApp(onDismiss: () {});

        expect(find.dismiss, findsOne);
      },
    );

    testWidgets(
      'Callout should always display an icon and message.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.icon, findsOne);
        expect(find.message, findsOne);
      },
    );

    testWidgets(
      'Callout should render a child widget when child is provided.',
      (tester) async {
        const childKey = ValueKey('child');

        await tester.pumpTestApp(
          child: const Text('test message', key: childKey),
        );

        expect(find.byKey(childKey), findsOne);
      },
    );

    testWidgets(
      'Callout should render with type info by default'
      ' when type is not specified.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.callout.type, CalloutType.info);
      },
    );

    testWidgets(
      'Callout should use the info icon for CalloutType.info.',
      (tester) async {
        await tester.pumpTestApp(type: .info);

        expect(tester.icon.icon, Icons.info_outlined);
      },
    );

    testWidgets(
      'Callout should use the check_circle icon for CalloutType.success.',
      (tester) async {
        await tester.pumpTestApp(type: .success);

        expect(tester.icon.icon, Icons.check_circle_outlined);
      },
    );

    testWidgets(
      'Callout should use the warning_amber icon for CalloutType.warning.',
      (tester) async {
        await tester.pumpTestApp(type: .warning);

        expect(tester.icon.icon, Icons.warning_amber_outlined);
      },
    );

    testWidgets(
      'Callout should use the error_outline icon for CalloutType.error.',
      (tester) async {
        await tester.pumpTestApp(type: .error);

        expect(tester.icon.icon, Icons.error_outline_outlined);
      },
    );
  });

  group('♻️ Input Formatting', () {});

  group('👆 User Interaction', () {
    testWidgets(
      'onDismiss should be called exactly once when dismiss button is tapped.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onDismiss: () => count++);

        await tester.tapDismiss();

        expect(count, 1);
      },
    );

    testWidgets(
      'onDismiss should not be called when Callout body is tapped.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onDismiss: () => count++);

        await tester.tapCalloutBody();

        expect(count, 0);
      },
    );
  });

  group('♿️ Accessibility', () {
    testWidgets(
      'Callout icon'
      ' should have a semantics label corresponding to CalloutType.info.',
      (tester) async {
        await tester.pumpTestApp(type: .info);

        expect(find.bySemanticsLabel(l10n.info), findsOne);
      },
    );

    testWidgets(
      'Callout icon'
      ' should have a semantics label corresponding to CalloutType.success.',
      (tester) async {
        await tester.pumpTestApp(type: .success);

        expect(find.bySemanticsLabel(l10n.success), findsOne);
      },
    );

    testWidgets(
      'Callout icon'
      ' should have a semantics label corresponding to CalloutType.warning.',
      (tester) async {
        await tester.pumpTestApp(type: .warning);

        expect(find.bySemanticsLabel(l10n.warning), findsOne);
      },
    );

    testWidgets(
      'Callout icon'
      ' should have a semantics label corresponding to CalloutType.error.',
      (tester) async {
        await tester.pumpTestApp(type: .error);

        expect(find.bySemanticsLabel(l10n.error), findsOne);
      },
    );
  });

  group('⚠️ Error Handling', () {
    testWidgets(
      'Callout should display an empty string message without throwing.',
      (tester) async {
        await tester.pumpTestApp(message: '');

        expect(tester.takeException(), isNull);
        expect(find.callout, findsOne);
      },
    );

    testWidgets(
      'Callout should display a medium message without overflow errors.',
      (tester) async {
        await tester.pumpTestApp(message: LoremIpsum.medium);

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'Callout should render correctly'
      ' when message contains special characters.',
      (tester) async {
        const message = '🎉 Hello\nWorld &amp; "quotes"';

        await tester.pumpTestApp(message: message);

        expect(find.text(message), findsOne);
        expect(tester.takeException(), isNull);
      },
    );
  });
}
