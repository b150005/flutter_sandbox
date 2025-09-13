import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/data/repositories/firebase/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'delayed_mock_firebase_auth.dart';

@visibleForTesting
class FirebaseAuthTestUtils {
  const FirebaseAuthTestUtils._();

  static Override mockFirebaseAuthProvider({
    bool signedIn = false,
    MockUser? mockUser,
    Map<String, List<String>>? signInMethodsForEmail,
    bool verifyEmailAutomatically = true,
    Duration? delay,
  }) => firebaseAuthProvider.overrideWith(
    (_) => delay == null
        ? MockFirebaseAuth(
            signedIn: signedIn,
            mockUser: mockUser,
            signInMethodsForEmail: signInMethodsForEmail,
            verifyEmailAutomatically: verifyEmailAutomatically,
          )
        : DelayedMockFirebaseAuth(
            signedIn: signedIn,
            mockUser: mockUser,
            signInMethodsForEmail: signInMethodsForEmail,
            verifyEmailAutomatically: verifyEmailAutomatically,
            delay: delay,
          ),
  );
}
