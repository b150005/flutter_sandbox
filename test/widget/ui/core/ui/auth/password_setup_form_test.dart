import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_sandbox/data/repositories/firebase/auth/auth_repository.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/password_setup_form.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/password_text_form_field.dart';
import 'package:flutter_sandbox/ui/core/ui/callout.dart';
import 'package:flutter_sandbox/ui/core/ui/status_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../testing/auth/auth_test_input.dart';
import '../../../../../../testing/auth/fake_auth_repository.dart';
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

  Finder get passwordTextFormField => byWidgetPredicate(
    (widget) =>
        widget is PasswordTextFormField && widget.key == WidgetKeys.password,
  );

  Finder get confirmPasswordTextFormField => byWidgetPredicate(
    (widget) =>
        widget is PasswordTextFormField &&
        widget.key == WidgetKeys.confirmPassword,
  );

  Finder get statusIndicator => byType(StatusIndicator);

  Finder get setupPasswordButton => byWidgetPredicate(
    (widget) =>
        widget is FilledButton && widget.key == WidgetKeys.setupPassword,
  );
}

Future<void>? _noOp() => null;

extension _WidgetTesterExtension on WidgetTester {
  Future<void> pumpTestApp({
    bool isAuthenticated = true,
    Completer<void>? updatePasswordCompleter,
    Future<void>? Function() onSubmit = _noOp,
  }) => pumpWidget(
    TestApp(
      overrides: [
        authRepositoryProvider.overrideWith(
          () => FakeAuthRepository(
            isAuthenticated: isAuthenticated,
            updatePasswordCompleter: updatePasswordCompleter,
          ),
        ),
      ],
      child: PasswordSetupForm(onSubmit: onSubmit),
    ),
  );

  FilledButton get setupPasswordButton =>
      widget<FilledButton>(find.setupPasswordButton);

  Iterable<StatusIndicator> get statusIndicators =>
      widgetList<StatusIndicator>(find.byType(StatusIndicator));
}

extension _UserInteraction on WidgetTester {
  Future<void> dismissCallout() async {
    await tap(find.calloutDismissButton);
    await pump();
  }

  Future<void> enter(String password, {bool confirmPassword = false}) async {
    await enterText(
      confirmPassword
          ? find.confirmPasswordTextFormField
          : find.passwordTextFormField,
      password,
    );

    await pump();
  }

  Future<void> tapPasswordTextFormField() async {
    await tap(find.passwordTextFormField);
    await pump();
  }

  Future<void> tapConfirmPasswordTextFormField() async {
    await tap(find.confirmPasswordTextFormField);
    await pump();
  }

  Future<void> submit() async {
    await testTextInput.receiveAction(.done);
    await pump();
  }

  Future<void> tapSetupPasswordButton() async {
    await tap(find.setupPasswordButton);
    await pump();
  }
}

void main() {
  group('🎨 UI Structure', () {
    testWidgets(
      'Two PasswordTextFormField widgets should be rendered.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.byType(PasswordTextFormField), findsExactly(2));
      },
    );

    testWidgets(
      'Five StatusIndicator widgets should be rendered.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.statusIndicator, findsExactly(5));
      },
    );

    testWidgets(
      'The setup password button should be rendered.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.setupPasswordButton, findsOne);
      },
    );

    testWidgets(
      'No error callout should be displayed on initial render.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.callout, findsNothing);
      },
    );

    testWidgets(
      'The setup password button'
      ' should show the setUpPassword label when not loading.',
      (tester) async {
        final updatePasswordCompleter = Completer<void>();
        addTearDown(updatePasswordCompleter.complete);

        await tester.pumpTestApp(
          updatePasswordCompleter: updatePasswordCompleter,
        );
      },
    );
  });

  group('🔍 Input Validation', () {
    testWidgets(
      'Tapping the setup password button with an empty password'
      ' should not call onSubmit.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          onSubmit: () {
            count++;

            return null;
          },
        );
        await tester.tapSetupPasswordButton();

        expect(count, 0);
      },
    );

    testWidgets(
      'Tapping the setup password button with a non-compliant password'
      ' should not call onSubmit.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          onSubmit: () {
            count++;

            return null;
          },
        );

        await tester.enter(AuthTestInput.tooShortPassword);
        await tester.enter(
          AuthTestInput.tooShortPassword,
          confirmPassword: true,
        );
        await tester.tapSetupPasswordButton();

        expect(count, 0);
      },
    );

    testWidgets(
      'Tapping the setup password button'
      ' when the confirm password does not match should not call onSubmit.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          onSubmit: () {
            count++;

            return null;
          },
        );

        await tester.enter(AuthTestInput.minLengthPassword);
        await tester.enter(AuthTestInput.longerThanMinLengthPassword);
        await tester.tapSetupPasswordButton();

        expect(count, 0);
      },
    );

    testWidgets(
      'Tapping the setup password button'
      ' with a valid password and a matching confirm password'
      ' should call onSubmit.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          onSubmit: () {
            count++;

            return null;
          },
        );

        await tester.enter(AuthTestInput.validPassword);
        await tester.enter(AuthTestInput.validPassword, confirmPassword: true);
        await tester.tapSetupPasswordButton();

        expect(count, 1);
      },
    );
  });

  group('♻️ Input Formatting', () {
    testWidgets(
      'All status indicators except satisfiesMaxLength'
      ' should be invalid on initial render.',
      (tester) async {
        await tester.pumpTestApp();

        for (final statusIndicator in tester.statusIndicators) {
          expect(
            statusIndicator.isValid,
            statusIndicator.key == WidgetKeys.passwordMaxLengthStatus
                ? isTrue
                : isFalse,
          );
        }
      },
    );

    testWidgets(
      'All status indicators should be valid'
      ' when a fully compliant password is entered.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter(AuthTestInput.validPassword);

        for (final statusIndicator in tester.statusIndicators) {
          expect(statusIndicator.isValid, isTrue);
        }
      },
    );
  });

  group('👆 User Interactions', () {
    testWidgets(
      'Tapping the setup password button with valid inputs'
      ' should show a loading indicator while updatePassword is in progress.',
      (tester) async {
        final updatePasswordCompleter = Completer<void>();
        addTearDown(updatePasswordCompleter.complete);

        await tester.pumpTestApp(
          updatePasswordCompleter: updatePasswordCompleter,
        );

        await tester.enter(AuthTestInput.validPassword);
        await tester.enter(AuthTestInput.validPassword, confirmPassword: true);
        await tester.tapSetupPasswordButton();

        expect(
          tester.setupPasswordButton.child,
          isA<CircularProgressIndicator>(),
        );
      },
    );

    testWidgets(
      'The setup password button should be disabled'
      ' while updatePassword is in progress.',
      (tester) async {
        final updatePasswordCompleter = Completer<void>();
        addTearDown(updatePasswordCompleter.complete);

        await tester.pumpTestApp(
          updatePasswordCompleter: updatePasswordCompleter,
        );

        await tester.enter(AuthTestInput.validPassword);
        await tester.enter(AuthTestInput.validPassword, confirmPassword: true);
        await tester.tapSetupPasswordButton();

        expect(tester.setupPasswordButton.enabled, isFalse);
      },
    );

    testWidgets(
      'Tapping the setup password button while loading'
      ' should not trigger another submission.',
      (tester) async {
        var count = 0;

        final updatePasswordCompleter = Completer<void>();
        addTearDown(updatePasswordCompleter.complete);

        await tester.pumpTestApp(
          updatePasswordCompleter: updatePasswordCompleter,
          onSubmit: () {
            count++;

            return null;
          },
        );

        await tester.enter(AuthTestInput.validPassword);
        await tester.enter(AuthTestInput.validPassword, confirmPassword: true);
        await tester.tapSetupPasswordButton();
        await tester.tapSetupPasswordButton();

        expect(count, 0);
      },
    );

    testWidgets(
      'Submitting the password field should call onSubmit.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          onSubmit: () {
            count++;

            return null;
          },
        );

        await tester.enter(AuthTestInput.validPassword);
        await tester.enter(AuthTestInput.validPassword, confirmPassword: true);
        await tester.tapPasswordTextFormField();
        await tester.submit();

        expect(count, 1);
      },
    );

    testWidgets(
      'Submitting the confirm password field should call onSubmit.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          onSubmit: () {
            count++;

            return null;
          },
        );

        await tester.enter(AuthTestInput.validPassword);
        await tester.enter(AuthTestInput.validPassword, confirmPassword: true);
        await tester.tapConfirmPasswordTextFormField();
        await tester.submit();

        expect(count, 1);
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
      'An error callout should be displayed when updatePassword fails.',
      (tester) async {
        await tester.pumpTestApp(isAuthenticated: false);

        await tester.enter(AuthTestInput.validPassword);
        await tester.enter(AuthTestInput.validPassword, confirmPassword: true);
        await tester.tapSetupPasswordButton();

        expect(find.callout, findsOne);
      },
    );

    testWidgets(
      'The error callout should be cleared'
      ' when the setup password button is tapped again after a failure.',
      (tester) async {
        await tester.pumpTestApp(isAuthenticated: false);

        await tester.enter(AuthTestInput.validPassword);
        await tester.enter(AuthTestInput.validPassword, confirmPassword: true);
        await tester.tapSetupPasswordButton();
        await tester.dismissCallout();

        expect(find.callout, findsNothing);
      },
    );
  });
}
