import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/button_size.dart';
import 'package:flutter_sandbox/ui/core/ui/callout.dart';
import 'package:flutter_sandbox/ui/core/ui/email_text_form_field.dart';
import 'package:flutter_sandbox/ui/core/ui/password_text_form_field.dart';
import 'package:flutter_sandbox/ui/sample/firebase/login/widgets/login_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../../testing/auth/firebase_auth_test_utils.dart';
import '../../../../../../../testing/auth/test_user.dart';
import '../../../../../../../testing/utils/app_localization_utils.dart';
import '../../../../../../../testing/utils/widget_key_finder.dart';

void main() {
  Widget loginFormApp({List<Override> overrides = const []}) => ProviderScope(
    overrides: overrides,
    child: const MaterialApp(
      home: Scaffold(
        body: LoginForm(),
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

  FilledButton findLoginButton(WidgetTester tester) =>
      tester.widget<FilledButton>(WidgetKeyFinder.login);

  group('🎨 UI elements', () {
    testWidgets(
      'LoginForm should have an email & password textfield,'
      ' a password forgot link and a login button.',
      (tester) async {
        await tester.pumpWidget(loginFormApp());

        final l10n = AppLocalizationUtils.readL10n(tester);

        expect(WidgetKeyFinder.loginForm, findsOneWidget);
        expect(find.byType(Form), findsOneWidget);

        expect(find.byType(EmailTextFormField), findsOneWidget);

        expect(find.byType(PasswordTextFormField), findsOneWidget);

        expect(WidgetKeyFinder.forgotPassword, findsOneWidget);
        expect(
          find.widgetWithText(TextButton, l10n.forgotPassword),
          findsOneWidget,
        );

        expect(WidgetKeyFinder.login, findsOneWidget);
        expect(find.widgetWithText(FilledButton, l10n.login), findsOneWidget);
      },
    );

    testWidgets('Email textfield should have correct properties.', (
      tester,
    ) async {
      await tester.pumpWidget(loginFormApp());

      final emailTextField = findEmailTextField(tester);

      expect(emailTextField.textInputAction, TextInputAction.next);
    });

    testWidgets('Password textfield should have correct properties.', (
      tester,
    ) async {
      await tester.pumpWidget(loginFormApp());

      final passwordTextField = findPasswordTextField(tester);

      expect(passwordTextField.textInputAction, TextInputAction.done);
    });

    testWidgets('Login button should have correct properties.', (tester) async {
      await tester.pumpWidget(loginFormApp());

      final loginButton = findLoginButton(tester);

      expect(loginButton.enabled, isTrue);
      expect(
        loginButton.style?.fixedSize,
        WidgetStatePropertyAll(ButtonSize.lg.fullWidth),
      );
    });

    testWidgets(
      'Loading indicator should be displayed during authentication'
      ' and should be hided after that.',
      (tester) async {
        await tester.pumpWidget(
          loginFormApp(
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

        await tester.tap(WidgetKeyFinder.login);

        await tester.pump();

        // final loginButton = findLoginButton(tester);

        // FIXME(b150005): ローディング UI が表示されることを検証
        // expect(loginButton.child, isA<CircularProgressIndicator>());

        await tester.pumpAndSettle();

        expect(find.widgetWithText(FilledButton, l10n.login), findsOneWidget);
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
        await tester.pumpWidget(loginFormApp());

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

        await tester.tap(WidgetKeyFinder.login);

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
      'Only one login request is executed when login button is tapped'
      ' multiple times.',
      (tester) async {},
    );
  });
}
