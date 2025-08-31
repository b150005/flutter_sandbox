import 'package:flutter/material.dart';

abstract final class WidgetKeys {
  const WidgetKeys._();

  static final loginForm = LabeledGlobalKey<FormState>('loginForm');
  static final signUpForm = LabeledGlobalKey<FormState>('signUpForm');
  static final passwordSetupForm = LabeledGlobalKey<FormState>(
    'passwordSetupForm',
  );

  static const ValueKey<String> email = ValueKey('email');
  static const ValueKey<String> password = ValueKey('password');
  static const ValueKey<String> forgotPassword = ValueKey('forgotPassword');
  static const ValueKey<String> login = ValueKey('login');
  static const ValueKey<String> signUp = ValueKey('signUp');
  static const ValueKey<String> confirmPassword = ValueKey('confirmPassword');
  static const ValueKey<String> setupPassword = ValueKey('setupPassword');
}
