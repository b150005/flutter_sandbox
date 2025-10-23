import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/text_input_formatters.dart';
import 'package:flutter_sandbox/ui/core/ui/email_text_form_field.dart';
import 'package:flutter_sandbox/ui/core/ui/label.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../testing/utils/app_localization_utils.dart';
import '../../../../../testing/utils/widget_key_finder.dart';

void main() {
  Widget emailTextFormFieldApp({
    TextEditingController? controller,
    TextInputAction? textInputAction,
  }) => ProviderScope(
    child: MaterialApp(
      builder: (context, child) => Theme(
        data: ThemeData.light(
          useMaterial3: true,
        ).copyWith(extensions: []),
        child: child!,
      ),
      home: Scaffold(
        body: EmailTextFormField(
          controller: controller,
          textInputAction: textInputAction,
        ),
      ),
    ),
  );

  const invalidEmail = 'invalid@example.c';
  const validEmail = 'valid@example.com';

  TextFormField findEmailTextFormField(WidgetTester tester) =>
      tester.widget<TextFormField>(WidgetKeyFinder.email);

  TextField findEmailTextField(WidgetTester tester) => tester.widget<TextField>(
    find.descendant(
      of: WidgetKeyFinder.email,
      matching: find.byType(TextField),
    ),
  );

  group('🎨 UI elements', () {
    testWidgets('EmailTextFormField should have a label'
        ' and an email TextFormField.', (
      tester,
    ) async {
      await tester.pumpWidget(emailTextFormFieldApp());

      expect(find.byType(Label), findsOneWidget);
      expect(WidgetKeyFinder.email, findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets(
      'Email textfield should have correct properties with default values.',
      (
        tester,
      ) async {
        await tester.pumpWidget(emailTextFormFieldApp());

        final l10n = AppLocalizationUtils.readL10n(tester);

        final label = tester.widget<Label>(find.byType(Label));

        expect(label.text, l10n.email);

        final emailTextFormField = findEmailTextFormField(tester);
        final emailTextField = findEmailTextField(tester);

        expect(emailTextFormField.controller, isNull);
        expect(
          emailTextField.decoration?.hintText,
          EmailTextFormField.exampleEmailAddress,
        );
        expect(emailTextField.keyboardType, TextInputType.emailAddress);
        expect(emailTextField.textInputAction, isNull);
        expect(emailTextField.autocorrect, isFalse);
        expect(emailTextField.inputFormatters, [
          TextInputFormatters.noWhitespace,
        ]);
        expect(
          emailTextFormField.autovalidateMode,
          AutovalidateMode.onUserInteraction,
        );
      },
    );

    testWidgets(
      'Email textfield should have correct properties'
      ' when parameters are provided.',
      (tester) async {
        final textEditingController = TextEditingController();
        const textInputAction = TextInputAction.done;

        await tester.pumpWidget(
          emailTextFormFieldApp(
            controller: textEditingController,
            textInputAction: textInputAction,
          ),
        );

        final emailTextFormField = findEmailTextFormField(tester);
        final emailTextField = findEmailTextField(tester);

        expect(emailTextFormField.controller, textEditingController);
        expect(emailTextField.textInputAction, textInputAction);
      },
    );
  });

  group('🔍 Input validation', () {
    testWidgets(
      'Email textfield should display error message for invalid input.',
      (tester) async {
        await tester.pumpWidget(emailTextFormFieldApp());

        var emailTextField = findEmailTextField(tester);

        expect(emailTextField.controller?.text, isEmpty);
        expect(emailTextField.decoration?.errorText, isNull);

        await tester.enterText(WidgetKeyFinder.email, invalidEmail);
        await tester.pump();

        emailTextField = findEmailTextField(tester);

        expect(emailTextField.controller?.text, invalidEmail);
        expect(emailTextField.decoration?.errorText, isNotNull);

        await tester.enterText(WidgetKeyFinder.email, validEmail);
        await tester.pump();

        emailTextField = findEmailTextField(tester);

        expect(emailTextField.controller?.text, validEmail);
        expect(emailTextField.decoration?.errorText, isNull);
      },
    );
  });

  group('♻️ Input formatting', () {
    testWidgets(
      'Email textfield should not allow whitespace input.',
      (tester) async {
        const whitespace = ' ';

        await tester.pumpWidget(emailTextFormFieldApp());

        var emailTextField = findEmailTextField(tester);

        expect(emailTextField.controller?.text, isEmpty);

        await tester.enterText(WidgetKeyFinder.email, whitespace);
        await tester.pump();

        emailTextField = findEmailTextField(tester);

        expect(emailTextField.controller?.text, isEmpty);
      },
    );
  });

  group('👆 User interaction', () {});

  group('♿️ Accessibility', () {});

  group('⚡️ Performance', () {});
}
