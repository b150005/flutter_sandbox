import 'package:flutter/material.dart';
import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_test/flutter_test.dart';

@visibleForTesting
class WidgetKeyFinder {
  const WidgetKeyFinder._();

  static final Finder signInForm = find.byKey(WidgetKeys.signInForm);
  static final Finder email = find.byKey(WidgetKeys.email);
  static final Finder password = find.byKey(WidgetKeys.password);
  static final Finder togglePasswordVisibility = find.byKey(
    WidgetKeys.togglePasswordVisibility,
  );
  static final Finder forgotPassword = find.byKey(WidgetKeys.forgotPassword);
  static final Finder signIn = find.byKey(WidgetKeys.signIn);

  static final Finder icon = find.byKey(WidgetKeys.icon);
  static final Finder message = find.byKey(WidgetKeys.message);
  static final Finder dismiss = find.byKey(WidgetKeys.dismiss);
  static final Finder save = find.byKey(WidgetKeys.save);
}
