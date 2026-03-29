import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_sandbox/core/config/l10n/app_localizations_en.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/email_text_form_field.dart';
import 'package:flutter_sandbox/ui/core/ui/label.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../testing/auth/auth_test_input.dart';
import '../../../../../../testing/fixtures/lorem_ipsum.dart';
import '../../../../../../testing/widgets/test_app.dart';

extension _CommonFindersExtension on CommonFinders {
  Finder get textFormField => byWidgetPredicate(
    (widget) => widget is TextFormField && widget.key == WidgetKeys.email,
  );
}

extension _WidgetTesterExtension on WidgetTester {
  Future<void> pumpTestApp({
    String? labelText,
    TextEditingController? controller,
    TextInputAction? textInputAction,
    ValueChanged<String>? onFieldSubmitted,
  }) => pumpWidget(
    TestApp(
      child: EmailTextFormField(
        labelText: labelText,
        controller: controller,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
      ),
    ),
  );

  Label get label => widget<Label>(find.byType(Label));

  TextField get textField => widget<TextField>(
    find.descendant(of: find.textFormField, matching: find.byType(TextField)),
  );
}

extension _EmailTextFormFieldInteraction on WidgetTester {
  Future<void> enter(String email) async {
    if (email.isEmpty) {
      await enter('a');
    }

    await enterText(find.textFormField, email);
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
    testWidgets(
      'Label should display the default email text'
      ' when labelText is not provided.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.label.text, l10n.email);
      },
    );

    testWidgets(
      'Label should display the custom text when labelText is provided.',
      (tester) async {
        await tester.pumpTestApp(labelText: LoremIpsum.tiny);

        expect(tester.label.text, LoremIpsum.tiny);
      },
    );

    testWidgets(
      'TextFormField should display the example email address as hint text.',
      (tester) async {
        await tester.pumpTestApp();

        expect(
          tester.textField.decoration?.hintText,
          EmailTextFormField.exampleEmailAddress,
        );
      },
    );

    testWidgets(
      'TextFormField should use the email keyboard type.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.textField.keyboardType, TextInputType.emailAddress);
      },
    );

    testWidgets(
      'TextFormField should have autocorrect disabled.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.textField.autocorrect, isFalse);
      },
    );
  });

  group('🔍 Input Validation', () {
    testWidgets(
      'No error should be displayed before the user interacts with the field.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.textField.decoration?.errorText, isNull);
      },
    );

    testWidgets(
      'An error should be displayed'
      ' when the field is left empty after interaction.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter(AuthTestInput.empty);

        expect(tester.textField.decoration?.errorText, l10n.requiredField);
      },
    );

    testWidgets(
      'An error should be displayed when an invalid email format is entered.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter(AuthTestInput.tooShortTldEmail);

        expect(tester.textField.decoration?.errorText, l10n.invalidEmailFormat);
      },
    );

    testWidgets(
      'An error should be cleared'
      ' when a valid email address is entered after an invalid one.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter(AuthTestInput.tooShortTldEmail);
        await tester.enter(AuthTestInput.validEmail);

        expect(tester.textField.decoration?.errorText, isNull);
      },
    );
  });

  group('♻️ Input Formatting', () {
    testWidgets(
      'A whitespace character entered into the field'
      ' should not be reflected in the text.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter(AuthTestInput.whitespaces);

        expect(tester.textField.controller?.text, isEmpty);
      },
    );

    testWidgets(
      'Multiple whitespace characters entered into the field'
      ' should be all removed.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter(AuthTestInput.whitespaceEmail);

        expect(tester.textField.controller?.text, AuthTestInput.validEmail);
      },
    );

    testWidgets(
      'Non-whitespace characters'
      ' should be entered into the field without modification.',
      (tester) async {
        await tester.pumpTestApp();

        const nonWhitespaceEmail = AuthTestInput.validEmail;

        await tester.enter(nonWhitespaceEmail);

        expect(tester.textField.controller?.text, nonWhitespaceEmail);
      },
    );

    testWidgets(
      'onFieldSubmitted should be called with the whitespace-stripped email'
      ' when the field is submitted after entering text with whitespace.',
      (tester) async {
        String? result;

        await tester.pumpTestApp(
          textInputAction: .done,
          onFieldSubmitted: (value) => result = value,
        );

        await tester.enter(AuthTestInput.whitespaceEmail);
        await tester.submit();

        expect(result, AuthTestInput.validEmail);
      },
    );
  });

  group('👆 User Interaction', () {
    testWidgets(
      'onFieldSubmitted should be called with the entered email'
      ' when the field is submitted.',
      (tester) async {
        String? result;

        await tester.pumpTestApp(
          textInputAction: .done,
          onFieldSubmitted: (value) => result = value,
        );

        const email = AuthTestInput.validEmail;

        await tester.enter(email);
        await tester.submit();

        expect(result, email);
      },
    );

    testWidgets(
      'onFieldSubmitted should not be called'
      ' when the field has not been submitted.',
      (tester) async {
        String? result;

        await tester.pumpTestApp(
          textInputAction: .done,
          onFieldSubmitted: (value) => result = value,
        );

        await tester.enter(AuthTestInput.validEmail);

        expect(result, isNull);
      },
    );

    testWidgets(
      'The field should not throw when onFieldSubmitted is not provided'
      ' and the field is submitted.',
      (tester) async {
        await tester.pumpTestApp(textInputAction: .done);

        await tester.enter(AuthTestInput.validEmail);
        await tester.submit();

        expect(tester.takeException(), isNull);
      },
    );
  });

  group('♿️ Accessibility', () {
    testWidgets(
      'The email autofill hint should be set on the TextFormField.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.textField.autofillHints, contains(AutofillHints.email));
      },
    );
  });
}
