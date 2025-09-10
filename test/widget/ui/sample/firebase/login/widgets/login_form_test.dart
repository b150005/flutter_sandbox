import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/button_size.dart';
import 'package:flutter_sandbox/core/utils/exceptions/app_exception.dart';
import 'package:flutter_sandbox/ui/core/ui/email_text_form_field.dart';
import 'package:flutter_sandbox/ui/core/ui/password_text_form_field.dart';
import 'package:flutter_sandbox/ui/sample/firebase/login/widgets/login_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../testing/utils/app_localization_utils.dart';
import '../../../../../../../testing/utils/widget_key_finder.dart';

void main() {
  const loginFormApp = ProviderScope(
    child: MaterialApp(home: Scaffold(body: LoginForm())),
  );

  TextField findEmailTextField(WidgetTester tester) => tester.widget<TextField>(
    find.descendant(
      of: WidgetKeyFinder.email,
      matching: find.byType(TextField),
    ),
  );

  TextField findPasswordTextField(WidgetTester tester) =>
      tester.widget<TextField>(
        find.descendant(
          of: WidgetKeyFinder.password,
          matching: find.byType(TextField),
        ),
      );

  FilledButton findLoginFilledButton(WidgetTester tester) =>
      tester.widget<FilledButton>(WidgetKeyFinder.login);

  setUpAll(() {
    provideDummy<Result<UserCredential, AppException>>(
      const Result.error(AppException.unknown()),
    );
  });

  group('🎨 UI elements', () {
    testWidgets(
      'LoginForm should have an email & password textfield,'
      ' a password forgot link,'
      ' and a login button.',
      (tester) async {
        await tester.pumpWidget(loginFormApp);

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
      await tester.pumpWidget(loginFormApp);

      final emailTextField = findEmailTextField(tester);

      expect(emailTextField.textInputAction, TextInputAction.next);
    });

    testWidgets('Password textfield should have correct properties.', (
      tester,
    ) async {
      await tester.pumpWidget(loginFormApp);

      final passwordTextField = findPasswordTextField(tester);

      expect(passwordTextField.textInputAction, TextInputAction.done);
    });

    testWidgets('Login button should have correct properties.', (tester) async {
      await tester.pumpWidget(loginFormApp);

      final loginFilledButton = findLoginFilledButton(tester);

      expect(loginFilledButton.enabled, isTrue);
      expect(
        loginFilledButton.style?.fixedSize,
        WidgetStatePropertyAll(ButtonSize.lg.fullWidth),
      );
    });
  });

  group('🔍 Input validation', () {});

  group('♻️ Input formatting', () {});

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
