import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/text_input_formatters.dart';
import 'package:flutter_sandbox/core/utils/authentications/firebase_auth_validator.dart';
import 'package:flutter_sandbox/ui/core/ui/label.dart';
import 'package:flutter_sandbox/ui/core/ui/password_text_form_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../testing/utils/app_localization_utils.dart';
import '../../../../../../testing/utils/widget_key_finder.dart';

void main() {
  Widget passwordTextFormFieldApp({
    TextEditingController? controller,
    String? hintText,
    TextInputAction? textInputAction,
    void Function(String password)? onChanged,
    String? Function(String? password)? validator,
  }) => ProviderScope(
    child: MaterialApp(
      home: Scaffold(
        body: PasswordTextFormField(
          controller: controller,
          labelText: hintText,
          textInputAction: textInputAction,
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    ),
  );

  const invalidPassword = 'invalidPassword';
  const validPassword = 'validPassw0rd';

  TextFormField findPasswordTextFormField(WidgetTester tester) =>
      tester.widget<TextFormField>(WidgetKeyFinder.password);

  TextField findPasswordTextField(WidgetTester tester) =>
      tester.widget<TextField>(
        find.descendant(
          of: WidgetKeyFinder.password,
          matching: find.byType(TextField),
        ),
      );

  group('🎨 UI elements', () {
    testWidgets(
      'PasswordTextFormField should have a label, a password TextFormField,'
      ' and a visibility toggle IconButton.',
      (tester) async {
        await tester.pumpWidget(passwordTextFormFieldApp());

        expect(find.byType(Label), findsOneWidget);
        expect(WidgetKeyFinder.password, findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        expect(WidgetKeyFinder.togglePasswordVisibility, findsOneWidget);
      },
    );

    testWidgets(
      'Password textfield should have correct properties with default values.',
      (tester) async {
        await tester.pumpWidget(passwordTextFormFieldApp());

        final l10n = AppLocalizationUtils.readL10n(tester);

        final label = tester.widget<Label>(find.byType(Label));

        expect(label.text, l10n.password);

        final passwordTextFormField = findPasswordTextFormField(tester);
        final passwordTextField = findPasswordTextField(tester);

        expect(passwordTextFormField.controller, isNull);
        expect(passwordTextField.decoration?.hintText, l10n.password);
        expect(passwordTextField.keyboardType, TextInputType.visiblePassword);
        expect(passwordTextField.textInputAction, isNull);
        expect(passwordTextField.autocorrect, isFalse);
        expect(passwordTextField.enableSuggestions, isFalse);
        expect(
          passwordTextField.maxLength,
          FirebaseAuthValidator.passwordMaxLength,
        );
        expect(passwordTextField.inputFormatters, [
          TextInputFormatters.noWhitespace,
        ]);
        expect(
          passwordTextFormField.autovalidateMode,
          AutovalidateMode.onUserInteraction,
        );
      },
    );

    testWidgets(
      'Password textfield should have correct properties'
      ' when parameters are provided.',
      (tester) async {
        final textEditingController = TextEditingController();
        const hintText = 'hint';
        const textInputAction = TextInputAction.done;

        await tester.pumpWidget(
          passwordTextFormFieldApp(
            controller: textEditingController,
            hintText: hintText,
            textInputAction: textInputAction,
          ),
        );

        final passwordTextFormField = findPasswordTextFormField(tester);
        final passwordTextField = findPasswordTextField(tester);

        expect(passwordTextFormField.controller, textEditingController);
        expect(passwordTextField.decoration?.hintText, hintText);
        expect(passwordTextField.textInputAction, textInputAction);
      },
    );

    testWidgets(
      'Password visibility toggle button should change state'
      ' when tapped.',
      (tester) async {
        await tester.pumpWidget(passwordTextFormFieldApp());

        var passwordTextField = findPasswordTextField(tester);
        var icon = tester.widget<Icon>(find.byType(Icon));

        expect(passwordTextField.obscureText, isTrue);
        expect(icon.icon, Icons.visibility_rounded);

        await tester.tap(WidgetKeyFinder.togglePasswordVisibility);

        await tester.pump();

        passwordTextField = findPasswordTextField(tester);
        icon = tester.widget<Icon>(find.byType(Icon));

        expect(passwordTextField.obscureText, isFalse);
        expect(icon.icon, Icons.visibility_off_rounded);
      },
    );
  });

  group('🔍 Input validation', () {
    testWidgets(
      'Password textfield should display error message for invalid input.',
      (tester) async {
        await tester.pumpWidget(passwordTextFormFieldApp());

        var passwordTextField = findPasswordTextField(tester);

        expect(passwordTextField.controller?.text, isEmpty);
        expect(passwordTextField.decoration?.errorText, isNull);

        await tester.enterText(WidgetKeyFinder.password, invalidPassword);
        await tester.pump();

        passwordTextField = findPasswordTextField(tester);

        expect(passwordTextField.controller?.text, invalidPassword);
        expect(passwordTextField.decoration?.errorText, isNotNull);

        await tester.enterText(WidgetKeyFinder.password, validPassword);
        await tester.pump();

        passwordTextField = findPasswordTextField(tester);

        expect(passwordTextField.controller?.text, validPassword);
        expect(passwordTextField.decoration?.errorText, isNull);
      },
    );
  });

  group('♻️ Input formatting', () {
    testWidgets('Password textfield should not allow whitespace input.', (
      tester,
    ) async {
      await tester.pumpWidget(passwordTextFormFieldApp());

      await tester.enterText(WidgetKeyFinder.password, ' ');
      await tester.pump();

      final passwordTextField = findPasswordTextField(tester);

      expect(passwordTextField.controller?.text, isEmpty);
    });
  });
}
