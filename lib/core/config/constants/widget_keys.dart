import 'package:flutter/material.dart';

abstract final class WidgetKeys {
  const WidgetKeys._();

  static final signInForm = LabeledGlobalKey<FormState>('signInForm');
  static final signUpForm = LabeledGlobalKey<FormState>('signUpForm');
  static final passwordSetupForm = LabeledGlobalKey<FormState>(
    'passwordSetupForm',
  );
  static final emailVerificationForm = LabeledGlobalKey<FormState>(
    'emailVerificationForm',
  );
  static final userProfileForm = LabeledGlobalKey<FormState>('userProfileForm');

  static const ValueKey<String> callout = ValueKey('callout');
  static const ValueKey<String> icon = ValueKey('icon');
  static const ValueKey<String> message = ValueKey('message');
  static const ValueKey<String> dismiss = ValueKey('dismiss');
  static const ValueKey<String> email = ValueKey('email');
  static const ValueKey<String> password = ValueKey('password');
  static const ValueKey<String> togglePasswordVisibility = ValueKey(
    'togglePasswordVisibility',
  );
  static const ValueKey<String> forgotPassword = ValueKey('forgotPassword');
  static const ValueKey<String> signIn = ValueKey('signIn');
  static const ValueKey<String> signUp = ValueKey('signUp');
  static const ValueKey<String> confirmPassword = ValueKey('confirmPassword');
  static const ValueKey<String> setupPassword = ValueKey('setupPassword');
  static const ValueKey<String> verifyEmail = ValueKey('verifyEmail');
  static const ValueKey<String> avatar = ValueKey('avatar');
}
