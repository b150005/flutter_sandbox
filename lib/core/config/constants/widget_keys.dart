import 'package:flutter/material.dart';

abstract final class WidgetKeys {
  const WidgetKeys._();

  static const ValueKey<String> appBar = ValueKey('appBar');

  static final signInForm = LabeledGlobalKey<FormState>('signInForm');
  static final signUpForm = LabeledGlobalKey<FormState>('signUpForm');
  static final passwordSetupForm = LabeledGlobalKey<FormState>(
    'passwordSetupForm',
  );
  static final emailVerificationForm = LabeledGlobalKey<FormState>(
    'emailVerificationForm',
  );
  static final emailEditForm = LabeledGlobalKey<FormState>('emailEditForm');
  static final phoneNumberEditForm = LabeledGlobalKey<FormState>(
    'phoneNumberEditForm',
  );

  static const ValueKey<String> userProfileCard = ValueKey('userProfileCard');
  static const ValueKey<String> userAuthDetailCard = ValueKey(
    'userAuthDetailCard',
  );

  static const ValueKey<String> authRequiredDialog = ValueKey(
    'authRequiredDialog',
  );

  static const ValueKey<String> back = ValueKey('back');
  static const ValueKey<String> dismiss = ValueKey('dismiss');
  static const ValueKey<String> save = ValueKey('save');

  static const ValueKey<String> callout = ValueKey('callout');

  static const ValueKey<String> icon = ValueKey('icon');
  static const ValueKey<String> message = ValueKey('message');
  static const ValueKey<String> email = ValueKey('email');
  static const ValueKey<String> password = ValueKey('password');
  static const ValueKey<String> togglePasswordVisibility = ValueKey(
    'togglePasswordVisibility',
  );
  static const ValueKey<String> forgotPassword = ValueKey('forgotPassword');
  static const ValueKey<String> signIn = ValueKey('signIn');
  static const ValueKey<String> signUp = ValueKey('signUp');
  static const ValueKey<String> signOut = ValueKey('signOut');

  static const ValueKey<String> confirmPassword = ValueKey('confirmPassword');
  static const ValueKey<String> setupPassword = ValueKey('setupPassword');
  static const ValueKey<String> verifyEmail = ValueKey('verifyEmail');

  static const ValueKey<String> editEmail = ValueKey('editEmail');
  static const ValueKey<String> editPhoneNumber = ValueKey(
    'editPhoneNumber',
  );

  static const ValueKey<String> avatar = ValueKey('avatar');
  static const ValueKey<String> displayName = ValueKey('displayName');
  static const ValueKey<String> uid = ValueKey('uid');
  static const ValueKey<String> isAnonymous = ValueKey('isAnonymous');
  static const ValueKey<String> emailVerified = ValueKey('emailVerified');
  static const ValueKey<String> phoneNumber = ValueKey('phoneNumber');
  static const ValueKey<String> photoURL = ValueKey('photoURL');
  static const ValueKey<String> refreshToken = ValueKey('refreshToken');
  static const ValueKey<String> tenantId = ValueKey('tenantId');
  static const ValueKey<String> creationTime = ValueKey('creationTime');
  static const ValueKey<String> lastSignInTime = ValueKey('lastSignInTime');
  static const ValueKey<String> providerId = ValueKey('providerId');
  static const ValueKey<String> signInProvider = ValueKey('signInProvider');
  static const ValueKey<String> signInSecondFactor = ValueKey(
    'signInSecondFactor',
  );
  static const ValueKey<String> token = ValueKey('token');
  static const ValueKey<String> authTime = ValueKey('authTime');
  static const ValueKey<String> issuedAtTime = ValueKey('issuedAtTime');
  static const ValueKey<String> expirationTime = ValueKey('expirationTime');
  static const ValueKey<String> claims = ValueKey('claims');

  static const ValueKey<String> errorRetry = ValueKey('errorRetry');
}
