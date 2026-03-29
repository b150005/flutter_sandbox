import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_sandbox/core/config/l10n/app_localizations_en.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/password_text_form_field.dart';
import 'package:flutter_sandbox/ui/core/ui/label.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../testing/auth/auth_test_input.dart';
import '../../../../../../testing/fixtures/lorem_ipsum.dart';
import '../../../../../../testing/widgets/test_app.dart';

extension _CommonFindersExtension on CommonFinders {
  Finder get textFormField => byWidgetPredicate(
    (widget) => widget is TextFormField && widget.key == WidgetKeys.password,
  );

  Finder get visibilityToggleButton => descendant(
    of: textFormField,
    matching: byWidgetPredicate(
      (widget) =>
          widget is IconButton &&
          widget.key == WidgetKeys.togglePasswordVisibility,
    ),
  );
}

extension _WidgetTesterExtension on WidgetTester {
  Future<void> pumpTestApp({
    String? labelText,
    TextEditingController? controller,
    TextInputAction? textInputAction,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    String? Function(String? password)? validator,
    Iterable<String>? autofillHints,
  }) => pumpWidget(
    TestApp(
      child: autofillHints == null
          ? PasswordTextFormField(
              labelText: labelText,
              controller: controller,
              textInputAction: textInputAction,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              validator: validator,
            )
          : PasswordTextFormField(
              labelText: labelText,
              controller: controller,
              textInputAction: textInputAction,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              validator: validator,
              autofillHints: autofillHints,
            ),
    ),
  );

  Label get label => widget<Label>(find.byType(Label));

  TextField get textField => widget<TextField>(
    find.descendant(of: find.textFormField, matching: find.byType(TextField)),
  );

  Icon get visibilityIcon => widget<Icon>(
    find.descendant(
      of: find.visibilityToggleButton,
      matching: find.byType(Icon),
    ),
  );
}

extension _PasswordTextFormFieldInteraction on WidgetTester {
  Future<void> enter(String password) async {
    if (password.isEmpty) {
      await enter('a');
    }

    await enterText(find.textFormField, password);
    await pump();
  }

  Future<void> submit() async {
    await testTextInput.receiveAction(.done);
    await pump();
  }

  Future<void> toggleVisibility() async {
    await tap(find.visibilityToggleButton);
    await pump();
  }
}

void main() {
  final l10n = AppLocalizationsEn();

  group('🎨 UI Structure', () {
    testWidgets(
      'Label should display the default password text'
      ' when labelText is not provided.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.label.text, l10n.password);
      },
    );

    testWidgets(
      'Label should display the custom text when labelText is provided.',
      (tester) async {
        const labelText = LoremIpsum.tiny;

        await tester.pumpTestApp(labelText: labelText);

        expect(tester.label.text, labelText);
      },
    );

    testWidgets(
      'TextFormField should use the visiblePassword keyboard type.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.textField.keyboardType, TextInputType.visiblePassword);
      },
    );

    testWidgets(
      'TextFormField should have autocorrect disabled.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.textField.autocorrect, isFalse);
      },
    );

    testWidgets(
      'TextFormField should have suggestions disabled.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.textField.enableSuggestions, isFalse);
      },
    );

    testWidgets(
      'TextFormField should obscure text by default.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.textField.obscureText, isTrue);
      },
    );

    testWidgets(
      'Visibility toggle icon should be visibility_outlined'
      ' when text is obscured.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.visibilityIcon.icon, Icons.visibility_outlined);
      },
    );

    testWidgets(
      'Text should be revealed'
      ' and icon should change to visibility_off_outlined'
      ' when the toggle is tapped.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.toggleVisibility();

        expect(tester.textField.obscureText, isFalse);
        expect(tester.visibilityIcon.icon, Icons.visibility_off_outlined);
      },
    );

    testWidgets(
      'Text should be re-obscured and icon should revert'
      ' when the toggle is tapped again.',
      (tester) async {
        await tester.pumpTestApp();

        final defaultIcon = tester.visibilityIcon.icon;

        await tester.toggleVisibility();
        await tester.toggleVisibility();

        expect(tester.textField.obscureText, isTrue);
        expect(tester.visibilityIcon.icon, defaultIcon);
      },
    );

    testWidgets(
      'TextFormField should have no textInputAction'
      ' when textInputAction is not provided.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.textField.textInputAction, isNull);
      },
    );

    testWidgets(
      'TextFormField should use the provided textInputAction'
      ' when textInputAction is specified.',
      (tester) async {
        const textInputAction = TextInputAction.next;

        await tester.pumpTestApp(textInputAction: textInputAction);

        expect(tester.textField.textInputAction, textInputAction);
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
      'An error should be displayed'
      ' when the password does not meet the requirements.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter(AuthTestInput.tooShortPassword);

        expect(
          tester.textField.decoration?.errorText,
          l10n.nonCompliantPassword,
        );
      },
    );

    testWidgets(
      'An error should be cleared'
      ' when a valid password is entered after an invalid one.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter(AuthTestInput.tooShortPassword);
        await tester.enter(AuthTestInput.validPassword);

        expect(tester.textField.decoration?.errorText, isNull);
      },
    );

    testWidgets(
      'A custom validator error message should be displayed'
      ' when a custom validator is provided and validation fails.',
      (tester) async {
        const customError = 'Custom validation error';

        await tester.pumpTestApp(validator: (_) => customError);

        await tester.enter(AuthTestInput.validPassword);

        expect(tester.textField.decoration?.errorText, customError);
      },
    );
  });

  group('♻️ Input Formatting', () {
    testWidgets(
      'A whitespace character entered into the field'
      ' should not be reflected in the text.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter(AuthTestInput.whitespacePassword);

        expect(tester.textField.controller?.text, AuthTestInput.validPassword);
      },
    );

    testWidgets(
      'Non-whitespace characters'
      ' should be entered into the field without modification.',
      (tester) async {
        await tester.pumpTestApp();

        const nonWhitespacePassword = AuthTestInput.validPassword;

        await tester.enter(nonWhitespacePassword);

        expect(tester.textField.controller?.text, nonWhitespacePassword);
      },
    );
  });

  group('👆 User Interaction', () {
    testWidgets(
      'The field should use the custom controller'
      ' when a controller is provided.',
      (tester) async {
        final controller = TextEditingController();
        addTearDown(controller.dispose);

        await tester.pumpTestApp(controller: controller);

        expect(tester.textField.controller, controller);
      },
    );

    testWidgets(
      'onChanged should be called with the entered text'
      ' when the field value changes.',
      (tester) async {
        String? result;

        await tester.pumpTestApp(onChanged: (value) => result = value);

        const password = AuthTestInput.validPassword;

        await tester.enter(password);

        expect(result, password);
      },
    );

    testWidgets(
      'onFieldSubmitted should be called with the entered password'
      ' when the field is submitted.',
      (tester) async {
        String? result;

        await tester.pumpTestApp(
          textInputAction: .done,
          onFieldSubmitted: (value) => result = value,
        );

        const password = AuthTestInput.validPassword;

        await tester.enter(password);
        await tester.submit();

        expect(result, password);
      },
    );
  });

  group('♿️ Accessibility', () {
    testWidgets(
      'The password autofill hint'
      ' should be set on the TextFormField by default.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.textField.autofillHints, const [AutofillHints.password]);
      },
    );

    testWidgets(
      'Custom autofill hints should override the default'
      ' when autofillHints is provided.',
      (tester) async {
        const autofillHints = [AutofillHints.newPassword];

        await tester.pumpTestApp(autofillHints: autofillHints);

        expect(tester.textField.autofillHints, autofillHints);
      },
    );
  });
}
