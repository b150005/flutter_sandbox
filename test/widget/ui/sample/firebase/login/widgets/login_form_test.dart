import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/sizes.dart';
import 'package:flutter_sandbox/core/config/constants/text_input_formatters.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_sandbox/core/config/l10n/app_localizations.dart'
    as l10n;
import 'package:flutter_sandbox/core/utils/authentications/firebase_auth_validator.dart';
import 'package:flutter_sandbox/core/utils/exceptions/app_exception.dart';
import 'package:flutter_sandbox/core/utils/l10n/app_localizations.dart';
import 'package:flutter_sandbox/ui/sample/firebase/login/widgets/login_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';

void main() {
  const loginForm = ProviderScope(
    child: MaterialApp(home: Scaffold(body: LoginForm())),
  );

  final loginFormKeyFinder = find.byKey(WidgetKeys.loginForm);
  final emailKeyFinder = find.byKey(WidgetKeys.email);
  final passwordKeyFinder = find.byKey(WidgetKeys.password);
  final forgotPasswordKeyFinder = find.byKey(WidgetKeys.forgotPassword);
  final loginKeyFinder = find.byKey(WidgetKeys.login);

  const invalidEmail = 'invalid@example.c';
  const validEmail = 'valid@example.com';

  const invalidPassword = 'invalidPassword';
  const validPassword = 'validPassw0rd';

  TextField findEmailTextField(WidgetTester tester) => tester.widget<TextField>(
    find.descendant(of: emailKeyFinder, matching: find.byType(TextField)),
  );

  TextField findPasswordTextField(WidgetTester tester) =>
      tester.widget<TextField>(
        find.descendant(
          of: passwordKeyFinder,
          matching: find.byType(TextField),
        ),
      );

  FilledButton findLoginFilledButton(WidgetTester tester) =>
      tester.widget<FilledButton>(loginKeyFinder);

  l10n.AppLocalizations readL10n(WidgetTester tester) =>
      tester.container().read(appLocalizationsProvider);

  setUpAll(() {
    provideDummy<Result<UserCredential, AppException>>(
      const Result.error(AppException.unknown()),
    );
  });

  group('🎨 UI elements', () {
    testWidgets(
      'LoginForm has an email & password textfield, a password forgot link,'
      ' and a login button.',
      (tester) async {
        await tester.pumpWidget(loginForm);

        final l10n = readL10n(tester);

        expect(loginFormKeyFinder, findsOneWidget);
        expect(find.byType(Form), findsOneWidget);

        expect(emailKeyFinder, findsOneWidget);

        expect(passwordKeyFinder, findsOneWidget);

        expect(forgotPasswordKeyFinder, findsOneWidget);
        expect(
          find.widgetWithText(TextButton, l10n.forgotPassword),
          findsOneWidget,
        );

        expect(loginKeyFinder, findsOneWidget);
        expect(find.widgetWithText(FilledButton, l10n.login), findsOneWidget);
      },
    );

    testWidgets('Email textfield has correct properties.', (tester) async {
      await tester.pumpWidget(loginForm);

      final emailTextField = findEmailTextField(tester);

      expect(emailTextField.keyboardType, TextInputType.emailAddress);
      expect(emailTextField.textInputAction, TextInputAction.next);
      expect(emailTextField.autocorrect, isFalse);
      expect(emailTextField.inputFormatters, [
        TextInputFormatters.noWhitespace,
      ]);
    });

    testWidgets('Password textfield has correct properties.', (tester) async {
      await tester.pumpWidget(loginForm);

      final passwordTextField = findPasswordTextField(tester);

      expect(passwordTextField.keyboardType, TextInputType.visiblePassword);
      expect(passwordTextField.textInputAction, TextInputAction.done);
      expect(passwordTextField.obscureText, isTrue);
      expect(passwordTextField.autocorrect, isFalse);
      expect(passwordTextField.enableSuggestions, isFalse);
      expect(
        passwordTextField.maxLength,
        FirebaseAuthValidator.passwordMaxLength,
      );
      expect(passwordTextField.inputFormatters, [
        TextInputFormatters.noWhitespace,
      ]);
    });

    testWidgets('Login button has correct properties.', (tester) async {
      await tester.pumpWidget(loginForm);

      final loginFilledButton = findLoginFilledButton(tester);

      expect(loginFilledButton.enabled, isTrue);
      expect(
        loginFilledButton.style?.fixedSize,
        WidgetStatePropertyAll(ButtonSize.lg.fullWidth),
      );
    });
  });

  group('🔍 Input validation', () {
    testWidgets(
      'Email textfield should display error message for invalid input.',
      (tester) async {
        await tester.pumpWidget(loginForm);

        var emailTextField = findEmailTextField(tester);

        expect(emailTextField.controller?.text, isEmpty);
        expect(emailTextField.decoration?.errorText, isNull);

        await tester.enterText(emailKeyFinder, invalidEmail);
        await tester.pump();

        emailTextField = findEmailTextField(tester);

        expect(emailTextField.controller?.text, invalidEmail);
        expect(emailTextField.decoration?.errorText, isNotNull);

        await tester.enterText(emailKeyFinder, validEmail);
        await tester.pump();

        emailTextField = findEmailTextField(tester);

        expect(emailTextField.controller?.text, validEmail);
        expect(emailTextField.decoration?.errorText, isNull);
      },
    );

    testWidgets(
      'Password textfield should display error message for invalid input.',
      (tester) async {
        await tester.pumpWidget(loginForm);

        var passwordTextField = findPasswordTextField(tester);

        expect(passwordTextField.controller?.text, isEmpty);
        expect(passwordTextField.decoration?.errorText, isNull);

        await tester.enterText(passwordKeyFinder, invalidPassword);
        await tester.pump();

        passwordTextField = findPasswordTextField(tester);

        expect(passwordTextField.controller?.text, invalidPassword);
        expect(passwordTextField.decoration?.errorText, isNotNull);

        await tester.enterText(passwordKeyFinder, validPassword);
        await tester.pump();

        passwordTextField = findPasswordTextField(tester);

        expect(passwordTextField.controller?.text, validPassword);
        expect(passwordTextField.decoration?.errorText, isNull);
      },
    );
  });

  group('♻️ Input formatting', () {
    testWidgets('Email textfield should not allow whitespace input.', (
      tester,
    ) async {
      await tester.pumpWidget(loginForm);

      await tester.enterText(emailKeyFinder, ' ');
      await tester.pump();

      final emailTextField = findEmailTextField(tester);

      expect(emailTextField.controller?.text, isEmpty);
    });

    testWidgets('Password textfield should not allow whitespace input.', (
      tester,
    ) async {
      await tester.pumpWidget(loginForm);

      await tester.enterText(passwordKeyFinder, ' ');
      await tester.pump();

      final passwordTextField = findPasswordTextField(tester);

      expect(passwordTextField.controller?.text, isEmpty);
    });
  });

  group('🦺 Form validation', () {});

  group('👆 User interaction', () {
    testWidgets(
      'Navigation bar/rail and other elements should be grouped'
      ' in the same forcus traversal order',
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
