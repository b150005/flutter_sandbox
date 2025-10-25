import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';

@immutable
abstract final class PreviewMockData {
  const PreviewMockData._();

  static final mockFirebaseAuth = MockFirebaseAuth(
    signedIn: true,
    mockUser: MockUser(
      uid: 'test-user-123',
      email: 'test@example.com',
      displayName: 'John Doe',
      phoneNumber: '+81-123-456-789',
      photoURL: 'https://picsum.photos/200',
      providerData: [
        UserInfo.fromJson({
          'uid': 'test@example.com',
          'email': 'test@example.com',
          'displayName': 'John Doe',
          'phoneNumber': '+81-123-456-789',
          'isAnonymous': false,
          'isEmailVerified': true,
          'providerId': 'password',
          'refreshToken': 'refresh-token-abc',
          'creationTimestamp': DateTime.utc(2000).millisecondsSinceEpoch,
          'lastSignInTimestamp': DateTime.utc(2001).millisecondsSinceEpoch,
        }),
        UserInfo.fromJson({
          'uid': 'test-user-abc',
          'email': 'test@example.com',
          'displayName': 'John Doe',
          'photoUrl': 'https://picsum.photos/200',
          'phoneNumber': '+81-123-456-789',
          'isAnonymous': false,
          'isEmailVerified': true,
          'providerId': 'google.com',
          'tenantId': 'google',
          'refreshToken': 'refresh-token-123',
          'creationTimestamp': DateTime.utc(2002).millisecondsSinceEpoch,
          'lastSignInTimestamp': DateTime.utc(2003).millisecondsSinceEpoch,
        }),
      ],
      refreshToken: 'refresh-token-123',
      metadata: UserMetadata(
        DateTime.utc(2004).millisecondsSinceEpoch,
        DateTime.utc(2005).millisecondsSinceEpoch,
      ),
      idTokenResult: IdTokenResult(
        PigeonIdTokenResult(
          authTimestamp: DateTime.utc(2006).millisecondsSinceEpoch,
          issuedAtTimestamp: DateTime.utc(2007).millisecondsSinceEpoch,
          expirationTimestamp: DateTime.utc(2008).millisecondsSinceEpoch,
          signInProvider: 'google.com',
          token: 'fake_token',
          claims: {
            'sub': 'user-123',
            'email': 'test@example.com',
            'email_verified': true,
            'name': 'John Doe',
            'picture': 'https://picsum.photos/200',
            'exp': DateTime.utc(2009).millisecondsSinceEpoch,
            'iat': DateTime.utc(2010).millisecondsSinceEpoch,
            'auth_time': DateTime.utc(2011).millisecondsSinceEpoch,
          },
        ),
      ),
      idTokenAuthTime: DateTime.utc(2012),
      idTokenExp: DateTime.utc(2013),
      customClaim: {
        'sub': 'user-123',
        'email': 'test@example.com',
        'email_verified': true,
        'name': 'John Doe',
        'picture': 'https://picsum.photos/200',
        'exp': DateTime.utc(2014).millisecondsSinceEpoch,
        'iat': DateTime.utc(2015).millisecondsSinceEpoch,
        'auth_time': DateTime.utc(2017).millisecondsSinceEpoch,
      },
    ),
  );
}
