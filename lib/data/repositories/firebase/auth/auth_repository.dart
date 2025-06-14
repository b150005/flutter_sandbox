import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/exception/app_exception.dart';
import '../../../../core/utils/extensions/firebase_auth_exception.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../../../core/utils/logging/log_message.dart';
import '../../../../core/utils/logging/logger.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
User? currentUser(Ref ref) {
  return ref.watch(firebaseAuthProvider).currentUser;
}

@riverpod
class AuthRepository extends _$AuthRepository {
  /// Firebase Authentication の認証状態を取得する
  ///
  /// @see [Check current auth state](https://firebase.google.com/docs/auth/flutter/start#auth-state)
  @override
  Stream<User?> build() {
    _ensureFirebaseInitialized();

    final auth = ref.watch(firebaseAuthProvider);
    return auth.userChanges();
  }

  void _ensureFirebaseInitialized() {
    if (Firebase.apps.isEmpty) {
      Logger.instance.e(LogMessage.firebaseNotInitialized);

      final l10n = ref.read(appLocalizationsProvider);

      throw AppException.serviceUnavailable(
        l10n.errorServiceTemporarilyUnavailable,
      );
    }
  }

  Future<Result<T, AppException>> _executeWithFirebaseAuth<T>(
    Future<T> Function() operation,
  ) async {
    try {
      _ensureFirebaseInitialized();

      final result = await operation();

      return Result.success(result);
    } on AppException catch (error) {
      return Result.error(error);
    } on FirebaseAuthException catch (error, stackTrace) {
      Logger.instance.e(error.message, error: error, stackTrace: stackTrace);

      return Result.error(error.toAppException(ref));
    } on Exception catch (error, stackTrace) {
      Logger.instance.e(
        LogMessage.unhandledError,
        error: error,
        stackTrace: stackTrace,
      );

      return const Result.error(AppException.unknown());
    }
  }

  /// メールアドレスとパスワードを用いてユーザを作成する
  ///
  /// @see [Create a user](https://firebase.google.com/docs/auth/flutter/manage-users#create_a_user)
  Future<Result<UserCredential, AppException>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    final auth = ref.read(firebaseAuthProvider);

    return _executeWithFirebaseAuth(
      () =>
          auth.createUserWithEmailAndPassword(email: email, password: password),
    );
  }

  /// メールアドレスとパスワードを用いてサインインを行う
  ///
  /// @see [Sign in a user with an email address and password](https://firebase.google.com/docs/auth/flutter/password-auth#sign_in_a_user_with_an_email_address_and_password)
  Future<Result<UserCredential, AppException>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    final auth = ref.read(firebaseAuthProvider);

    return _executeWithFirebaseAuth(
      () => auth.signInWithEmailAndPassword(email: email, password: password),
    );
  }
}
