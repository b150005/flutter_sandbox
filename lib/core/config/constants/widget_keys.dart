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
  static const ValueKey<String> displayName = ValueKey('displayName');
  static const ValueKey<String> uid = ValueKey('uid');
  static const ValueKey<String> isAnonymous = ValueKey('isAnonymous');
  static const ValueKey<String> emailVerified = ValueKey('emailVerified');
  static const ValueKey<String> phoneNumber = ValueKey('phoneNumber');
  static const ValueKey<String> photoURL = ValueKey('photoURL');

  static const ValueKey<String> refreshToken = ValueKey('refreshToken');
  static const ValueKey<String> createdAt = ValueKey('createdAt');
  static const ValueKey<String> lastSignInAt = ValueKey('lastSignInAt');
  static const ValueKey<String> signInProvider = ValueKey('signInProvider');
  static const ValueKey<String> signInSecondFactor = ValueKey(
    'signInSecondFactor',
  );
  static const ValueKey<String> token = ValueKey('token');
  static const ValueKey<String> authenticatedAt = ValueKey('authenticatedAt');
  static const ValueKey<String> issuedAt = ValueKey('issuedAt');
  static const ValueKey<String> expiredAt = ValueKey('expiredAt');

  static const ValueKey<String> payloadClaims = ValueKey('payloadClaims');

  static const ValueKey<String> save = ValueKey('save');
}
