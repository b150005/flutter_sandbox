import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/button_size.dart';
import 'package:flutter_sandbox/ui/core/ui/callout.dart';
import 'package:flutter_sandbox/ui/core/ui/email_text_form_field.dart';
import 'package:flutter_sandbox/ui/core/ui/password_text_form_field.dart';
import 'package:flutter_sandbox/ui/sample/firebase/sign-in/widgets/sign_in_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../../testing/auth/firebase_auth_test_utils.dart';
import '../../../../../../../testing/auth/test_user.dart';
import '../../../../../../../testing/utils/app_localization_utils.dart';
import '../../../../../../../testing/utils/widget_key_finder.dart';

void main() {
  Widget signInFormApp({List<Override> overrides = const []}) => ProviderScope(
    overrides: overrides,
    child: const MaterialApp(
      home: Scaffold(
        body: SignInForm(),
      ),
    ),
  );

  TextField findEmailTextField(WidgetTester tester) => tester.widget<TextField>(
    find.descendant(
      of: find.byType(EmailTextFormField),
      matching: find.byType(TextField),
    ),
  );

  TextField findPasswordTextField(WidgetTester tester) =>
      tester.widget<TextField>(
        find.descendant(
          of: find.byType(PasswordTextFormField),
          matching: find.byType(TextField),
        ),
      );

  FilledButton findSignInButton(WidgetTester tester) =>
      tester.widget<FilledButton>(WidgetKeyFinder.signIn);

  group('🎨 UI elements', () {
    testWidgets(
      'SignInForm should have an email & password textfield,'
      ' a password forgot link and a Sign-in button.',
      (tester) async {
        await tester.pumpWidget(signInFormApp());

        final l10n = AppLocalizationUtils.readL10n(tester);

        expect(WidgetKeyFinder.signInForm, findsOneWidget);
        expect(find.byType(Form), findsOneWidget);

        expect(find.byType(EmailTextFormField), findsOneWidget);

        expect(find.byType(PasswordTextFormField), findsOneWidget);

        expect(WidgetKeyFinder.forgotPassword, findsOneWidget);
        expect(
          find.widgetWithText(TextButton, l10n.forgotPassword),
          findsOneWidget,
        );

        expect(WidgetKeyFinder.signIn, findsOneWidget);
        expect(find.widgetWithText(FilledButton, l10n.signIn), findsOneWidget);
      },
    );

    testWidgets('Email textfield should have correct properties.', (
      tester,
    ) async {
      await tester.pumpWidget(signInFormApp());

      final emailTextField = findEmailTextField(tester);

      expect(emailTextField.textInputAction, TextInputAction.next);
    });

    testWidgets('Password textfield should have correct properties.', (
      tester,
    ) async {
      await tester.pumpWidget(signInFormApp());

      final passwordTextField = findPasswordTextField(tester);

      expect(passwordTextField.textInputAction, TextInputAction.done);
    });

    testWidgets('Sign-in button should have correct properties.', (
      tester,
    ) async {
      await tester.pumpWidget(signInFormApp());

      final signInButton = findSignInButton(tester);

      expect(signInButton.enabled, isTrue);
      expect(
        signInButton.style?.fixedSize,
        WidgetStatePropertyAll(ButtonSize.lg.fullWidth),
      );
    });

    testWidgets(
      'Loading indicator should be displayed during authentication'
      ' and should be hided after that.',
      (tester) async {
        await tester.pumpWidget(
          signInFormApp(
            overrides: [
              FirebaseAuthTestUtils.mockFirebaseAuthProvider(
                mockUser: MockUser(email: TestUser.valid.email),
                delay: const Duration(seconds: 10),
              ),
            ],
          ),
        );

        final l10n = AppLocalizationUtils.readL10n(tester);

        await tester.enterText(
          find.byType(EmailTextFormField),
          TestUser.valid.email,
        );
        await tester.enterText(
          find.byType(PasswordTextFormField),
          TestUser.valid.password,
        );

        await tester.pump();

        await tester.tap(WidgetKeyFinder.signIn);

        await tester.pump();

        // final signInButton = findSignInButton(tester);

        // FIXME(b150005): ローディング UI が表示されることを検証
        // expect(signInButton.child, isA<CircularProgressIndicator>());

        await tester.pumpAndSettle();

        expect(find.widgetWithText(FilledButton, l10n.signIn), findsOneWidget);
      },
    );
  });

  group('🔍 Input validation', () {});

  group('♻️ Input formatting', () {});

  group('🦺 Form validation', () {
    testWidgets(
      'Error message should be properly displayed on Callout'
      ' when authentication failed for wrong credentials.',
      (tester) async {
        await tester.pumpWidget(signInFormApp());

        // final l10n = AppLocalizationUtils.readL10n(tester);

        expect(find.byType(Callout), findsNothing);

        await tester.enterText(
          find.byType(EmailTextFormField),
          TestUser.invalidEmail.email,
        );
        await tester.enterText(
          find.byType(PasswordTextFormField),
          TestUser.invalidEmail.password,
        );

        await tester.pump();

        await tester.tap(WidgetKeyFinder.signIn);

        await tester.pumpAndSettle();

        // FIXME(b150005): Callout にエラーメッセージが表示されることを検証
        // expect(find.byType(Callout), findsOneWidget);
        // expect(
        //   find.textContaining(l10n.invalidEmailOrPassword),
        //   findsOneWidget,
        // );
      },
    );
  });

  group('👆 User interaction', () {
    testWidgets(
      'Navigation bar/rail and other elements should be grouped'
      ' in the same focus traversal order',
      (tester) async {},
    );
  });

  group('⚠️ Error handling', () {});

  group('♿️ Accessibility', () {});

  group('⚡️ Performance', () {
    testWidgets(
      'Only one sign-in request is executed when sign-in button is tapped'
      ' multiple times.',
      (tester) async {},
    );
  });
}
