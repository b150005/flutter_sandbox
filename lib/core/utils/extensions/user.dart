import 'package:firebase_auth/firebase_auth.dart';

extension UserExtension on User {
  bool get hasPhoneAuthProvider => providerData.any(
    (userInfo) => userInfo.providerId == PhoneAuthProvider.PROVIDER_ID,
  );
}
