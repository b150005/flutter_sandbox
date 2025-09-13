import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class DelayedMockFirebaseAuth extends MockFirebaseAuth {
  DelayedMockFirebaseAuth({
    super.signedIn,
    super.mockUser,
    super.signInMethodsForEmail,
    super.verifyEmailAutomatically,
    required this.delay,
  });

  final Duration delay;

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(delay);

    return super.signInWithEmailAndPassword(email: email, password: password);
  }
}
