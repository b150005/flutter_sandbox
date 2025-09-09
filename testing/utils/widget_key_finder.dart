import 'package:flutter_sandbox/core/config/constants/widget_keys.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetKeyFinder {
  const WidgetKeyFinder._();

  static final Finder loginForm = find.byKey(WidgetKeys.loginForm);
  static final Finder email = find.byKey(WidgetKeys.email);
  static final Finder password = find.byKey(WidgetKeys.password);
  static final Finder forgotPassword = find.byKey(WidgetKeys.forgotPassword);
  static final Finder login = find.byKey(WidgetKeys.login);

  static final Finder icon = find.byKey(WidgetKeys.icon);
  static final Finder message = find.byKey(WidgetKeys.message);
  static final Finder dismiss = find.byKey(WidgetKeys.dismiss);
}
