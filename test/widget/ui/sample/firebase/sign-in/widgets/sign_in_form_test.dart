import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_sandbox/data/repositories/firebase/auth/auth_repository.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/email_text_form_field.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/password_text_form_field.dart';
import 'package:flutter_sandbox/ui/core/ui/callout.dart';
import 'package:flutter_sandbox/ui/sample/firebase/sign-in/widgets/sign_in_form.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../testing/auth/fake_auth_repository.dart';
import '../../../../../../../testing/auth/test_user.dart';
import '../../../../../../../testing/l10n/app_localization_utils.dart';
import '../../../../../../../testing/widgets/test_app.dart';

extension _CommonFindersExtension on CommonFinders {
  Finder get autoFillGroup =>
      ancestor(of: byType(Form), matching: byType(AutofillGroup));

  Finder get callout => byType(Callout);

  Finder get calloutDismissButton => descendant(
    of: callout,
    matching: byWidgetPredicate(
      (widget) => widget is IconButton && widget.key == WidgetKeys.dismiss,
    ),
  );

  Finder get emailTextFormField => byType(EmailTextFormField);

  Finder get passwordTextFormField => byType(PasswordTextFormField);

  Finder get forgotPasswordButton => byWidgetPredicate(
    (widget) => widget is TextButton && widget.key == WidgetKeys.forgotPassword,
  );

  Finder get signInButton => byWidgetPredicate(
    (widget) => widget is FilledButton && widget.key == WidgetKeys.signIn,
  );
}

void _noOp() {}

extension _WidgetTesterExtension on WidgetTester {
  Future<void> pumpTestApp({
    Completer<void>? signInCompleter,
    VoidCallback onSuccess = _noOp,
    VoidCallback onForgotPasswordPressed = _noOp,
  }) => pumpWidget(
    TestApp(
      overrides: [
        authRepositoryProvider.overrideWith(
          () => FakeAuthRepository(signInCompleter: signInCompleter),
        ),
      ],
      child: SignInForm(
        onSuccess: onSuccess,
        onForgotPasswordPressed: onForgotPasswordPressed,
      ),
    ),
  );

  FilledButton get signInButton => widget<FilledButton>(find.signInButton);

  Text get signInButtonText => widget<Text>(
    find.descendant(of: find.signInButton, matching: find.byType(Text)),
  );
}

extension _UserInteraction on WidgetTester {
  Future<void> dismissCallout() async {
    await tap(find.calloutDismissButton);
    await pump();
  }

  Future<void> enterEmail(String email) async {
    await enterText(find.emailTextFormField, email);
    await pump();
  }

  Future<void> enterPassword(String password) async {
    await enterText(find.passwordTextFormField, password);
    await pump();
  }

  Future<void> tapPasswordTextFormField() async {
    await tap(find.passwordTextFormField);
    await pump();
  }

  Future<void> tapForgotPassword() async {
    await tap(find.forgotPasswordButton);
    await pump();
  }

  Future<void> tapSignInButton() async {
    await tap(find.signInButton);
    await pump();
  }

  Future<void> submit() async {
    await testTextInput.receiveAction(.done);
    await pump();
  }
}

void main() {
  final l10n = AppLocalizationUtils.en;

  group('🎨 UI Structure', () {
    testWidgets('EmailTextFormField should be rendered.', (tester) async {
      await tester.pumpTestApp();

      expect(find.emailTextFormField, findsOne);
    });

    testWidgets('PasswordTextFormField should be rendered.', (tester) async {
      await tester.pumpTestApp();

      expect(find.passwordTextFormField, findsOne);
    });

    testWidgets(
      'Forgot password button should be rendered.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.forgotPasswordButton, findsOne);
      },
    );

    testWidgets('Sign-in button should be rendered.', (tester) async {
      await tester.pumpTestApp();

      expect(find.signInButton, findsOne);
    });

    testWidgets(
      'No error callout should be displayed on initial render.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.callout, findsNothing);
      },
    );

    testWidgets(
      'Sign-in button should show the sign-in label when not loading.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.signInButtonText.data, l10n.signIn);
      },
    );

    testWidgets(
      'Sign-in button should show a loading indicator while signing in.',
      (tester) async {
        final signInCompleter = Completer<void>();
        addTearDown(signInCompleter.complete);

        await tester.pumpTestApp(signInCompleter: signInCompleter);

        await tester.enterEmail(TestUser.valid.email);
        await tester.enterPassword(TestUser.valid.password);
        await tester.tapSignInButton();

        expect(tester.signInButton.child, isA<CircularProgressIndicator>());
      },
    );
  });

  group('🔍 Input Validation', () {
    testWidgets(
      'onSuccess should not be called'
      ' when the sign-in button is tapped with empty fields.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onSuccess: () => count++);

        await tester.tapSignInButton();

        expect(count, 0);
      },
    );

    testWidgets(
      'onSuccess should not be called'
      ' when the sign-in button is tapped with an empty email.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onSuccess: () => count++);

        await tester.enterPassword(TestUser.valid.password);
        await tester.tapSignInButton();

        expect(count, 0);
      },
    );

    testWidgets(
      'onSuccess should not be called'
      ' when the sign-in button is tapped with an empty passowrd.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onSuccess: () => count++);

        await tester.enterEmail(TestUser.valid.email);
        await tester.tapSignInButton();

        expect(count, 0);
      },
    );

    testWidgets(
      'onSuccess should not be called'
      ' when the sign-in button is tapped with an invalid email.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onSuccess: () => count++);

        await tester.enterEmail(TestUser.invalidEmail.email);
        await tester.enterPassword(TestUser.invalidEmail.password);

        await tester.tapSignInButton();

        expect(count, 0);
      },
    );

    testWidgets(
      'onSuccess should not be called'
      ' when the sign-in button is tapped with a non-compliant password.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onSuccess: () => count++);

        await tester.enterEmail(TestUser.invalidPassword.email);
        await tester.enterPassword(TestUser.invalidPassword.password);

        await tester.tapSignInButton();

        expect(count, 0);
      },
    );
  });

  group('♻️ Input Formatting', () {});

  group('👆 User Interaction', () {
    testWidgets(
      'Tapping the sign-in button should trigger sign-in.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onSuccess: () => count++);

        await tester.enterEmail(TestUser.valid.email);
        await tester.enterPassword(TestUser.valid.password);
        await tester.tapSignInButton();

        expect(count, 1);
      },
    );

    testWidgets(
      'Submitting the password field should trigger sign-in.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onSuccess: () => count++);

        await tester.enterEmail(TestUser.valid.email);
        await tester.enterPassword(TestUser.valid.password);
        await tester.tapPasswordTextFormField();
        await tester.submit();

        expect(count, 1);
      },
    );

    testWidgets(
      'onForgotPasswordPressed should be called'
      ' when the forgot password button is tapped.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onForgotPasswordPressed: () => count++);

        await tester.tapForgotPassword();

        expect(count, 1);
      },
    );

    testWidgets(
      'Tapping the sign-in button while loading'
      ' should not trigger another sign-in attempt.',
      (tester) async {
        var count = 0;

        final signInCompleter = Completer<void>();
        addTearDown(signInCompleter.complete);

        await tester.pumpTestApp(
          signInCompleter: signInCompleter,
          onSuccess: () => count++,
        );

        await tester.enterEmail(TestUser.valid.email);
        await tester.enterPassword(TestUser.valid.password);
        await tester.tapSignInButton();

        await tester.tapSignInButton();

        expect(count, 0);
      },
    );
  });

  group('⚠️ Error Handling', () {
    testWidgets(
      'An error callout should be displayed when sign-in fails.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enterEmail(TestUser.unknown.email);
        await tester.enterPassword(TestUser.unknown.password);
        await tester.tapSignInButton();

        expect(find.callout, findsOne);
      },
    );

    testWidgets(
      'The error callout should be dismissed'
      ' when the dismiss button is tapped.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enterEmail(TestUser.unknown.email);
        await tester.enterPassword(TestUser.unknown.password);
        await tester.tapSignInButton();

        await tester.dismissCallout();

        expect(find.callout, findsNothing);
      },
    );

    testWidgets(
      'The error callout should not be displayed'
      ' without a prior sign-in attempt.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enterEmail(TestUser.unknown.email);
        await tester.enterPassword(TestUser.unknown.password);

        expect(find.callout, findsNothing);
      },
    );

    testWidgets(
      'The error callout should be dismissed'
      ' when the sign-in button is tapped again after a failed sign-in.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enterEmail(TestUser.invalidEmail.email);
        await tester.enterPassword(TestUser.valid.password);
        await tester.tapSignInButton();
        await tester.enterEmail(TestUser.valid.email);
        await tester.tapSignInButton();

        expect(find.callout, findsNothing);
      },
    );
  });

  group('♿️ Accessibility', () {
    testWidgets(
      'The form should be wrapped in an AutofillGroup.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.autoFillGroup, findsOne);
      },
    );
  });
}
