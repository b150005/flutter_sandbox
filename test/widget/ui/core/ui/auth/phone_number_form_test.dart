import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/durations.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_sandbox/core/config/l10n/app_localizations_en.dart';
import 'package:flutter_sandbox/core/utils/authentications/phone_number_generator.dart';
import 'package:flutter_sandbox/domain/models/phone_number.dart';
import 'package:flutter_sandbox/ui/core/extensions/build_context.dart';
import 'package:flutter_sandbox/ui/core/ui/auth/phone_number_form.dart';
import 'package:flutter_sandbox/ui/core/ui/label.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sealed_countries/sealed_countries.dart';

import '../../../../../../testing/auth/auth_test_input.dart';
import '../../../../../../testing/extensions/widget_tester.dart';
import '../../../../../../testing/widgets/test_app.dart';

extension _CommonFindersExtension on CommonFinders {
  Finder get form =>
      descendant(of: byType(PhoneNumberForm), matching: byType(Form));

  Finder get formField => byType(FormField<PhoneNumber>);

  Finder get label => byType(Label);

  Finder get decoratedBox => byWidgetPredicate(
    (widget) => widget is DecoratedBox && widget.key == WidgetKeys.outlineBox,
  );

  Finder get countryCodePicker => byType(CountryCodePicker);

  Finder get countryCodePickerScrollable => ancestor(
    of: byKey(WidgetKeys.searchableItemSliverList),
    matching: byType(Scrollable),
  );

  Finder get nationalNumberTextField => byWidgetPredicate(
    (widget) =>
        widget is TextField && widget.key == WidgetKeys.nationalNumberTextField,
  );

  Finder get countryCodeText => byWidgetPredicate(
    (widget) => widget is Text && widget.key == WidgetKeys.countryCodeText,
  );

  Finder get errorText => byWidgetPredicate(
    (widget) => widget is Text && widget.key == WidgetKeys.errorText,
  );
}

extension _WidgetTesterExtension on WidgetTester {
  Future<void> pumpTestApp({
    GlobalKey<FormState>? formKey,
    PhoneNumber initialValue = const PhoneNumber(),
    String? labelText,
    TextInputAction textInputAction = .done,
    ValueChanged<PhoneNumber>? onChanged,
    ValueChanged<PhoneNumber>? onSubmitted,
    bool enabled = true,
  }) => pumpWidget(
    TestApp(
      child: PhoneNumberForm(
        formKey: formKey,
        initialValue: initialValue,
        labelText: labelText,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
      ),
    ),
  );

  Color? get borderColor =>
      (widget<DecoratedBox>(find.decoratedBox).decoration as BoxDecoration)
          .border
          ?.top
          .color;

  Color? get outlineColor =>
      element(find.byType(PhoneNumberForm)).colorScheme.outline;

  Color? get errorColor =>
      element(find.byType(PhoneNumberForm)).colorScheme.error;

  Label get label => widget<Label>(find.label);

  CountryCodePicker get countryCodePicker =>
      widget<CountryCodePicker>(find.countryCodePicker);

  TextField get nationalNumberTextField =>
      widget<TextField>(find.nationalNumberTextField);

  Text get countryCodeText => widget<Text>(find.countryCodeText);

  Text get errorText => widget<Text>(find.errorText);
}

extension _UserInteraction on WidgetTester {
  Future<void> select(WorldCountry country) async {
    final itemFinder = find.byKey(ValueKey<String>(country.code));

    await tap(find.countryCodePicker);
    await pump();
    await scrollInto(
      itemFinder,
      200,
      scrollable: find.countryCodePickerScrollable,
    );
    await tap(itemFinder);
    await pump();
  }

  Future<void> tapNationalNumberTextField() async {
    await tap(find.nationalNumberTextField);
    await pump();
  }

  Future<void> enter(String nationalNumber, {Duration? duration}) async {
    await enterText(find.nationalNumberTextField, nationalNumber);
    await pump(); // useDebounced の Timer 発火
    if (duration != null) {
      await pump(duration);
    }
  }

  Future<bool> validate() async {
    final result = Form.of(element(find.formField)).validate();
    await pump();

    return result;
  }

  Future<void> submit() async {
    await testTextInput.receiveAction(.done);
    await pump();
  }
}

void main() {
  final l10n = AppLocalizationsEn();

  group('🎨 UI Structure', () {
    testWidgets('CountryCodePicker should be rendered.', (tester) async {
      await tester.pumpTestApp();

      expect(find.countryCodePicker, findsOne);
    });

    testWidgets(
      'National number TextField should be rendered.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.nationalNumberTextField, findsOne);
      },
    );

    testWidgets(
      'No error text should be displayed on initial render.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.errorText, findsNothing);
      },
    );

    testWidgets(
      'The country code prefix should be shown in the TextField'
      ' when countryCode is non-null.',
      (tester) async {
        final countryCode = AuthTestInput.usaCountryCode;

        await tester.pumpTestApp(
          initialValue: PhoneNumber(countryCode: countryCode),
        );

        expect(tester.countryCodeText.data, countryCode);
      },
    );

    testWidgets(
      'The form should be rendered without errors when countryCode is null.',
      (tester) async {
        await tester.pumpTestApp();

        expect(find.form, findsOne);
      },
    );

    testWidgets(
      'The specified labelText should be displayed when provided.',
      (tester) async {
        const labelText = 'Sample label';

        await tester.pumpTestApp(labelText: labelText);

        expect(tester.label.text, labelText);
      },
    );

    testWidgets(
      'The default phone number label should be displayed'
      ' when labelText is omitted.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.label.text, l10n.phoneNumber);
      },
    );

    testWidgets(
      'The outline color should reflect the outline color'
      ' on initial render.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.borderColor, tester.outlineColor);
      },
    );

    testWidgets(
      'The CountryCodePicker should be disabled when enabled is false.',
      (tester) async {
        await tester.pumpTestApp(enabled: false);

        expect(tester.countryCodePicker.enabled, isFalse);
      },
    );

    testWidgets(
      'The TextField should be disabled when enabled is false.',
      (tester) async {
        await tester.pumpTestApp(enabled: false);

        expect(tester.nationalNumberTextField.enabled, isFalse);
      },
    );

    testWidgets(
      'The initial nationalNumber should be displayed in the TextField.',
      (tester) async {
        final phoneNumber = AuthTestInput.validUsaPhoneNumber;

        await tester.pumpTestApp(initialValue: phoneNumber);

        expect(
          tester.nationalNumberTextField.controller?.text,
          phoneNumber.nationalNumber,
        );
      },
    );

    testWidgets(
      'No prefix icon should be shown in the TextField'
      ' when countryCode is null.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.nationalNumberTextField.decoration?.prefixIcon, isNull);
      },
    );

    testWidgets(
      'No prefix icon should be shown in the TextField'
      ' when countryCode is empty.',
      (tester) async {
        await tester.pumpTestApp(
          initialValue: AuthTestInput.emptyCountryCodePhoneNumber,
        );

        expect(tester.nationalNumberTextField.decoration?.prefixIcon, isNull);
      },
    );

    testWidgets(
      'The specified textInputAction should be applied to the TextField.',
      (tester) async {
        const textInputAction = TextInputAction.go;

        await tester.pumpTestApp(textInputAction: textInputAction);

        expect(tester.nationalNumberTextField.textInputAction, textInputAction);
      },
    );
  });

  group('🔍 Input Validation', () {
    testWidgets(
      'Submitting a valid phone number via the form'
      ' should pass validation when formKey is omitted.',
      (tester) async {
        PhoneNumber? result;

        await tester.pumpTestApp(
          initialValue: AuthTestInput.validUsaPhoneNumber,
          onSubmitted: (phoneNumber) => result = phoneNumber,
        );

        await tester.tapNationalNumberTextField();
        await tester.submit();

        expect(result, AuthTestInput.validUsaPhoneNumber);
        expect(find.errorText, findsNothing);
      },
    );

    testWidgets(
      'No error should be displayed when a valid phone number is validated.',
      (tester) async {
        final phoneNumber = PhoneNumber.fromParsed(
          PhoneNumberGenerator.example(
            countryCode: const WorldCountry.usa().idd.phoneCode(),
          ),
        );

        await tester.pumpTestApp(initialValue: phoneNumber);

        await tester.validate();

        expect(find.errorText, findsNothing);
      },
    );

    testWidgets(
      'Validating without selecting a country code'
      ' should display the countryCodeRequired error.',
      (tester) async {
        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaNationalNumberOnlyPhoneNumber,
        );

        await tester.validate();

        expect(tester.errorText.data, l10n.countryCodeRequired);
      },
    );

    testWidgets(
      'Validating with an empty national number'
      ' should display the nationalNumberRequired error.',
      (tester) async {
        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
        );

        await tester.validate();

        expect(tester.errorText.data, l10n.nationalNumberRequired);
      },
    );

    testWidgets(
      'Validating with an invalid phone number format'
      ' should display the invalidPhoneNumberFormat error.',
      (tester) async {
        await tester.pumpTestApp(
          initialValue: PhoneNumber(
            countryCode: AuthTestInput.usaCountryCode,
            nationalNumber: '123',
          ),
        );

        await tester.validate();

        expect(tester.errorText.data, l10n.invalidPhoneNumberFormat);
      },
    );
  });

  group('♻️ Input Formatting', () {
    testWidgets(
      'Non-numeric characters'
      ' should be rejected by the national number input formatter.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter('012abc!"#');

        expect(tester.nationalNumberTextField.controller?.text, '012');
      },
    );

    testWidgets(
      'The hint text should reflect the example national number'
      ' for the initial country code.',
      (tester) async {
        final countryCode = AuthTestInput.usaCountryCode;

        await tester.pumpTestApp(
          initialValue: PhoneNumber(countryCode: countryCode),
        );

        expect(
          tester.nationalNumberTextField.decoration?.hintText,
          PhoneNumberGenerator.example(
            countryCode: countryCode,
          ).nationalNumber.toString(),
        );
      },
    );

    testWidgets(
      'The hint text should update when the country code is changed.',
      (tester) async {
        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
        );

        final countryCode = const WorldCountry.jpn().idd.phoneCode();

        await tester.select(countryCode);

        expect(
          tester.nationalNumberTextField.decoration?.hintText,
          PhoneNumberGenerator.example(
            countryCode: countryCode,
          ).nationalNumber.toString(),
        );
      },
    );
  });

  group('👆 User Interactions', () {
    testWidgets(
      'onChanged should not be called before the debounce delay elapses.',
      (tester) async {
        PhoneNumber? result;

        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
          onChanged: (phoneNumber) => result = phoneNumber,
        );

        await tester.enter(
          AuthTestInput.usaNationalNumber,
          duration: kDefaultDebounceTimeout - const Duration(milliseconds: 1),
        );

        expect(result, isNull);
      },
    );

    testWidgets(
      'onChanged should not be called when typing is interrupted'
      ' before the debounce delay elapses.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
          onChanged: (_) => count++,
        );

        final nationalNumber = AuthTestInput.usaNationalNumber;

        await tester.enter(
          nationalNumber.substring(0, 1),
          duration: kDefaultDebounceTimeout - const Duration(milliseconds: 1),
        );
        await tester.enter(
          nationalNumber.substring(0, 2),
          duration: kDefaultDebounceTimeout - const Duration(milliseconds: 1),
        );

        expect(count, 0);
      },
    );

    testWidgets(
      'onChanged should be called only once when the debounce is flushed'
      ' before the timeout elapses.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
          onChanged: (_) => count++,
        );

        await tester.enter(
          AuthTestInput.usaNationalNumber,
          duration: kDefaultDebounceTimeout,
        );
        await tester.tapNationalNumberTextField();
        await tester.submit();

        expect(count, 1);
      },
    );

    testWidgets(
      'Selecting a country should call onChanged with the updated countryCode.',
      (tester) async {
        PhoneNumber? result;

        await tester.pumpTestApp(
          onChanged: (phoneNumber) => result = phoneNumber,
        );

        final countryCode = AuthTestInput.usaCountryCode;

        await tester.select(countryCode);

        expect(result?.countryCode, countryCode);
        expect(result?.nationalNumber, isEmpty);
      },
    );

    testWidgets(
      'Selecting a country should not throw when onChanged is null.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.select(AuthTestInput.usaCountryCode);

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'Entering a national number should not throw when onChanged is null.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.enter(
          AuthTestInput.usaNationalNumber,
          duration: kDefaultDebounceTimeout,
        );

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'Entering a national number'
      ' should call onChanged with the updated PhoneNumber'
      ' after the debounce delay elapses.',
      (tester) async {
        PhoneNumber? result;

        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
          onChanged: (phoneNumber) => result = phoneNumber,
        );

        final nationalNumber = AuthTestInput.usaNationalNumber;

        await tester.enter(nationalNumber, duration: kDefaultDebounceTimeout);

        expect(result?.countryCode, AuthTestInput.usaCountryCode);
        expect(result?.nationalNumber, nationalNumber);
      },
    );

    testWidgets(
      'Submitting the TextField should not throw when onSubmitted is null.',
      (tester) async {
        await tester.pumpTestApp();

        await tester.tapNationalNumberTextField();
        await tester.submit();

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'Submitting the TextField should not call onSubmitted'
      ' when enabled is false.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(
          initialValue: AuthTestInput.validUsaPhoneNumber,
          onSubmitted: (_) => count++,
          enabled: false,
        );

        await tester.tapNationalNumberTextField();
        await tester.submit();

        expect(count, 0);
      },
    );

    testWidgets(
      'Submitting the TextField'
      ' should call onSubmitted with the latest PhoneNumber'
      ' when validation passes.',
      (tester) async {
        PhoneNumber? result;

        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
          onSubmitted: (phoneNumber) => result = phoneNumber,
        );

        final nationalNumber = AuthTestInput.usaNationalNumber;

        await tester.enter(nationalNumber, duration: kDefaultDebounceTimeout);
        await tester.tapNationalNumberTextField();
        await tester.submit();

        expect(result?.countryCode, AuthTestInput.usaCountryCode);
        expect(result?.nationalNumber, nationalNumber);
      },
    );

    testWidgets(
      'Submitting the TextField should not call onSubmitted'
      ' when validation fails.',
      (tester) async {
        var count = 0;

        await tester.pumpTestApp(onSubmitted: (_) => count++);

        await tester.tapNationalNumberTextField();
        await tester.submit();

        expect(find.errorText, findsOne);
        expect(count, 0);
      },
    );

    testWidgets(
      'The debounce should be flushed before onSubmitted is called.',
      (tester) async {
        final events = <String>[];
        const onChangedEvent = 'onChanged';
        const onSubmittedEvent = 'onSubmitted';

        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
          onChanged: (_) => events.add(onChangedEvent),
          onSubmitted: (_) => events.add(onSubmittedEvent),
        );

        await tester.enter(
          AuthTestInput.usaNationalNumber,
          duration: kDefaultDebounceTimeout - const Duration(milliseconds: 1),
        );
        await tester.tapNationalNumberTextField();
        await tester.submit();

        expect(events, [onChangedEvent, onSubmittedEvent]);
      },
    );
  });

  group('♿️ Accessibility', () {
    testWidgets(
      'The TextField should have AutofillHints telephoneNumberNational set.',
      (tester) async {
        await tester.pumpTestApp();

        expect(tester.nationalNumberTextField.autofillHints, const [
          AutofillHints.telephoneNumberNational,
        ]);
      },
    );

    testWidgets(
      'The TextField should use TextInputType.phone as the keyboard type.',
      (tester) async {
        await tester.pumpTestApp();

        expect(
          tester.nationalNumberTextField.keyboardType,
          TextInputType.phone,
        );
      },
    );
  });

  group('⚠️ Error Handling', () {
    testWidgets(
      'The outline color should change to the error color'
      ' when validation fails.',
      (tester) async {
        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaNationalNumberOnlyPhoneNumber,
        );

        await tester.validate();

        expect(tester.borderColor, tester.errorColor);
      },
    );

    testWidgets(
      'The error message should be displayed in the error color'
      ' when validation fails.',
      (tester) async {
        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaNationalNumberOnlyPhoneNumber,
        );

        await tester.validate();

        expect(tester.errorText.style?.color, tester.errorColor);
      },
    );

    testWidgets(
      'The error text should be updated when the validation error changes.',
      (tester) async {
        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
        );

        await tester.validate();

        final firstErrorMessage = tester.errorText.data;

        await tester.enter('123', duration: kDefaultDebounceTimeout);
        await tester.validate();

        expect(tester.errorText.data, isNot(firstErrorMessage));
      },
    );

    testWidgets(
      'The error text should be hidden when the validation error is resolved.',
      (tester) async {
        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
        );

        await tester.validate();
        await tester.enter(
          AuthTestInput.usaNationalNumber,
          duration: kDefaultDebounceTimeout,
        );
        await tester.validate();

        expect(find.errorText, findsNothing);
      },
    );

    testWidgets(
      'The outline color should revert to the outline color'
      ' when the validation error is resolved.',
      (tester) async {
        await tester.pumpTestApp(
          initialValue: AuthTestInput.usaCountryCodeOnlyPhoneNumber,
        );

        await tester.validate();
        await tester.enter(
          AuthTestInput.usaNationalNumber,
          duration: kDefaultDebounceTimeout,
        );
        await tester.validate();

        expect(tester.borderColor, tester.outlineColor);
      },
    );
  });
}
