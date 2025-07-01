import 'package:flutter/material.dart';

abstract final class WidgetKeys {
  const WidgetKeys._();

  static final loginForm = LabeledGlobalKey<FormState>('loginForm');

  static const ValueKey<String> email = ValueKey('email');
  static const ValueKey<String> password = ValueKey('password');
  static const ValueKey<String> forgotPassword = ValueKey('forgotPassword');
  static const ValueKey<String> login = ValueKey('login');
  static const ValueKey<String> createNewAccount = ValueKey('createNewAccount');
}
