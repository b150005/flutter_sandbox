import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_sandbox/core/config/l10n/app_localizations_en.dart';
import 'package:flutter_sandbox/core/utils/exceptions/app_exception.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/email_input_form.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/email_text_form_field.dart';
import 'package:flutter_sandbox/ui/core/ui/callout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../../testing/auth/auth_test_input.dart';
import '../../../../../../testing/widgets/test_app.dart';

extension _CommonFindersExtension on CommonFinders {
  Finder get autofillGroup =>
      ancestor(of: byType(Form), matching: byType(AutofillGroup));

  Finder get callout => byType(Callout);

  Finder get calloutDismissButton => descendant(
    of: callout,
    matching: byWidgetPredicate(
      (widget) => widget is IconButton && widget.key == WidgetKeys.dismiss,
    ),
  );

  Finder get emailTextFormField => byType(EmailTextFormField);

  Finder get submitButton => byWidgetPredicate(
    (widget) => widget is FilledButton && widget.key == WidgetKeys.verifyEmail,
  );
}

extension _WidgetTesterExtension on WidgetTester {
  Future<void> pumpTestApp({
    FutureOr<Result<void, AppException>> Function(String email)? onSubmit,
    void Function(void)? onSuccess,
  }) => pumpWidget(
    TestApp(
      child: EmailInputForm(
        onSubmit: onSubmit ?? (_) => const .success(null),
        onSuccess: onSuccess ?? (_) {},
      ),
    ),
  );

  Callout get callout => widget<Callout>(find.callout);

  FilledButton get submitButton => widget<FilledButton>(find.submitButton);

  Text get submitButtonText => widget<Text>(
    find.descendant(of: find.submitButton, matching: find.byType(Text)),
  );
}

extension _UserInteraction on WidgetTester {
  Future<void> dismissCallout() async {
    await tap(find.calloutDismissButton);
    await pump();
  }

  Future<void> enter(String email) async {
    await enterText(find.emailTextFormField, email);
    await pump();
  }

  Future<void> tapVerifyEmailButton() async {
    await tap(find.submitButton);
    await pump();
  }

  Future<void> submit() async {
    await testTextInput.receiveAction(.done);
    await pump();
  }
}

void main() {
  final l10n = AppLocalizationsEn();

  group('🎨 UI Structure', () {
    testWidgets('EmailTextFormField should be rendered.', (tester) async {
      await tester.pumpTestApp();

      expect(find.emailTextFormField, findsOne);
    });

    testWidgets('Submit button should be rendered.', (tester) async {
      await tester.pumpTestApp();

      expect(find.submitButton, findsOne);
    });

    testWidgets(
      'No error callout should be displayed on initial render.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.callout, findsNothing);
      },
    );

    testWidgets(
      'Submit button should show the submit label when not loading.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.submitButtonText.data, l10n.submit);
      },
    );
  });

  group('🔍 Input Validation', () {
    testWidgets(
      'onSuccess should not be called'
      ' when the submit button is tapped with an empty email.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          onSubmit: (_) {
            count++;

            return const .success(null);
          },
        );

        await tester.tapVerifyEmailButton();

        expect(count, 0);
      },
    );

    testWidgets(
      'onSuccess should not be called'
      ' when the submit button is tapped with an invalid email.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          onSubmit: (_) {
            count++;

            return const .success(null);
          },
        );

        await tester.enter(AuthTestInput.tooShortTldEmail);
        await tester.tapVerifyEmailButton();

        expect(count, 0);
      },
    );
  });

  group('♻️ Input Formatting', () {});

  group('👆 User Interactions', () {
    testWidgets(
      'Tapping the submit button'
      ' should trigger onSubmit with the entered email.',
      (tester) async {
        String? result;

        await tester.pumpTestApp(
          onSubmit: (email) {
            result = email;

            return const .success(null);
          },
        );

        const email = AuthTestInput.validEmail;

        await tester.enter(email);
        await tester.tapVerifyEmailButton();

        expect(result, email);
      },
    );

    testWidgets(
      'Submitting the email field'
      ' should trigger onSubmit with the entered email.',
      (tester) async {
        String? result;

        await tester.pumpTestApp(
          onSubmit: (email) {
            result = email;

            return const .success(null);
          },
        );

        const email = AuthTestInput.validEmail;

        await tester.enter(email);
        await tester.submit();

        expect(result, email);
      },
    );

    testWidgets(
      'onSuccess should be called with the result when onSubmit succeeds.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          onSubmit: (_) => const .success(null),
          onSuccess: (_) => count++,
        );

        await tester.enter(AuthTestInput.validEmail);
        await tester.tapVerifyEmailButton();

        expect(count, 1);
      },
    );

    testWidgets(
      'The submit button should show a loading indicator'
      ' while onSubmit is in progress.',
      (tester) async {
        final completer = Completer<Result<void, AppException>>();
        addTearDown(() => completer.complete);

        await tester.pumpTestApp(onSubmit: (_) => completer.future);

        await tester.enter(AuthTestInput.validEmail);
        await tester.tapVerifyEmailButton();

        expect(tester.submitButton.child, isA<CircularProgressIndicator>());
      },
    );

    testWidgets(
      'The submit button should be disabled while onSubmit is in progress.',
      (tester) async {
        final completer = Completer<Result<void, AppException>>();
        addTearDown(() => completer.complete);

        await tester.pumpTestApp(onSubmit: (_) => completer.future);

        await tester.enter(AuthTestInput.validEmail);
        await tester.tapVerifyEmailButton();

        expect(tester.submitButton.enabled, isFalse);
      },
    );

    testWidgets(
      'Tapping the submit button while loading'
      ' should not trigger another submission.',
      (tester) async {
        final completer = Completer<Result<void, AppException>>();
        addTearDown(() => completer.complete);

        await tester.pumpTestApp(onSubmit: (_) => completer.future);

        await tester.enter(AuthTestInput.validEmail);
        await tester.submit();
        await tester.tapVerifyEmailButton();

        expect(tester.submitButton.enabled, isFalse);
      },
    );
  });

  group('♿️ Accessibility', () {
    testWidgets(
      'The form should be wrapped in an AutofillGroup.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.autofillGroup, findsOne);
      },
    );
  });

  group('⚠️ Error Handling', () {
    testWidgets(
      'An error callout should be displayed when onSubmit fails.',
      (tester) async {
        await tester.pumpTestApp(
          onSubmit: (_) => const .error(.unknown()),
        );

        await tester.enter(AuthTestInput.validEmail);
        await tester.tapVerifyEmailButton();

        expect(find.callout, findsOne);
      },
    );

    testWidgets(
      'The error message from onSubmit should be shown in the callout.',
      (tester) async {
        const message = 'Custom error message';

        await tester.pumpTestApp(
          onSubmit: (_) => const .error(.unknown(message)),
        );

        await tester.enter(AuthTestInput.validEmail);
        await tester.tapVerifyEmailButton();

        expect(tester.callout.message, message);
      },
    );

    testWidgets(
      'The error callout should be dismissed'
      ' when the dismiss button is tapped.',
      (tester) async {
        await tester.pumpTestApp(
          onSubmit: (_) => const .error(.unknown()),
        );

        await tester.enter(AuthTestInput.validEmail);
        await tester.tapVerifyEmailButton();
        await tester.dismissCallout();

        expect(find.callout, findsNothing);
      },
    );

    testWidgets(
      'The error callout should be cleared'
      ' when the submit button is tapped again after a failure.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          onSubmit: (_) {
            if (count == 0) {
              count++;

              return const .error(.unknown());
            }

            return const .success(null);
          },
        );

        await tester.enter(AuthTestInput.validEmail);
        await tester.tapVerifyEmailButton();
        await tester.tapVerifyEmailButton();

        expect(find.callout, findsNothing);
      },
    );
  });
}
