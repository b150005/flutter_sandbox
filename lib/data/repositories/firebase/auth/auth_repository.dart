import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/env/env.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/utils/exceptions/app_exception.dart';
import '../../../../core/utils/extensions/firebase_auth_exception.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../../../core/utils/logging/log_message.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../../core/utils/url/origin_resolver.dart';
import '../../shared_preferences/shared_preferences_repository.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

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

      throw AppException.serviceUnavailable(l10n.serviceTemporarilyUnavailable);
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

      final l10n = ref.read(appLocalizationsProvider);

      return Result.error(error.toAppException(l10n));
    } on Exception catch (error, stackTrace) {
      Logger.instance.e(
        LogMessage.unhandledError,
        error: error,
        stackTrace: stackTrace,
      );

      return const Result.error(AppException.unknown());
    }
  }

  /// メールリンク認証の URL が記載されたメールを送信する
  ///
  /// @see [Authenticate with Firebase Using Email Links](https://firebase.google.com/docs/auth/flutter/email-link-auth)
  /// @see [Passing State in Email Actions](https://firebase.google.com/docs/auth/flutter/passing-state-in-email-actions)
  Future<Result<void, AppException>> sendSignInLinkToEmail({
    required String email,
  }) => _executeWithFirebaseAuth(() async {
    final auth = ref.read(firebaseAuthProvider);

    final actionCodeSettings = ActionCodeSettings(
      androidPackageName: Env.instance.appId,
      handleCodeInApp: true,
      iOSBundleId: Env.instance.bundleId,
      url: OriginResolver.current + VerifyEmailScreenRoute.absolutePath,
    );

    await ref
        .read(sharedPreferencesRepositoryProvider)
        .setString(SharedPreferencesKeys.emailForSignIn.name, email);

    await auth.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: actionCodeSettings,
    );
  });

  /// メールリンク認証を用いてサインインを行う
  ///
  /// @see [Complete sign in with the email link](https://firebase.google.com/docs/auth/flutter/email-link-auth#complete_sign_in_with_the_email_link)
  Future<Result<UserCredential, AppException>> signInWithEmailLink({
    required Uri emailLink,
  }) => _executeWithFirebaseAuth(() async {
    final auth = ref.read(firebaseAuthProvider);
    final l10n = ref.read(appLocalizationsProvider);

    if (!auth.isSignInWithEmailLink(emailLink.toString())) {
      throw AppException.badRequest(l10n.invalidVerificationEmailLink);
    }

    final email = await ref
        .read(sharedPreferencesRepositoryProvider)
        .getString(SharedPreferencesKeys.emailForSignIn.name);

    if (email == null) {
      throw AppException.notFound(l10n.notFound);
    }

    return auth.signInWithEmailLink(
      email: email,
      emailLink: emailLink.toString(),
    );
  });

  /// 既存ユーザにパスワード認証を追加する
  ///
  /// @see [Set a user's password](https://firebase.google.com/docs/auth/flutter/manage-users#set_a_users_password)
  Future<Result<void, AppException>> updatePassword({
    required String password,
  }) => _executeWithFirebaseAuth(() {
    final auth = ref.read(firebaseAuthProvider);
    final l10n = ref.read(appLocalizationsProvider);

    if (auth.currentUser == null) {
      throw AppException.unauthorized(l10n.authenticationFailed);
    }

    return auth.currentUser!.updatePassword(password);
  });

  /// メールアドレスとパスワードを用いてサインインを行う
  ///
  /// @see [Sign in a user with an email address and password](https://firebase.google.com/docs/auth/flutter/password-auth#sign_in_a_user_with_an_email_address_and_password)
  Future<Result<UserCredential, AppException>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) => _executeWithFirebaseAuth(() {
    final auth = ref.read(firebaseAuthProvider);

    return auth.signInWithEmailAndPassword(email: email, password: password);
  });

  /// パスワード再設定のメールを送信する
  ///
  /// @see [Send a password reset email](https://firebase.google.com/docs/auth/flutter/manage-users#send_a_password_reset_email)
  Future<Result<void, AppException>> sendPasswordResetEmail({
    required String email,
  }) => _executeWithFirebaseAuth(() async {
    final auth = ref.read(firebaseAuthProvider);

    await ref
        .read(sharedPreferencesRepositoryProvider)
        .setString(SharedPreferencesKeys.emailForSignIn.name, email);

    return auth.sendPasswordResetEmail(
      email: email,
    );
  });

  /// メールアドレス更新の認証メールを送信する
  Future<Result<void, AppException>> verifyBeforeUpdateEmail(
    String email,
  ) => _executeWithFirebaseAuth(() {
    final auth = ref.read(firebaseAuthProvider);
    final l10n = ref.read(appLocalizationsProvider);

    if (auth.currentUser == null) {
      throw AppException.unauthorized(l10n.authenticationRequired);
    }

    final actionCodeSettings = ActionCodeSettings(
      androidPackageName: Env.instance.appId,
      handleCodeInApp: true,
      iOSBundleId: Env.instance.bundleId,
      url: FirebaseAuthScreenRoute.emailUpdateUrl(OriginResolver.current),
    );

    return auth.currentUser!.verifyBeforeUpdateEmail(
      email,
      actionCodeSettings,
    );
  });

  /// サインアウトする
  ///
  /// @see [Next steps](https://firebase.google.com/docs/auth/flutter/email-link-auth#next_steps)
  Future<Result<void, AppException>> signOut() => _executeWithFirebaseAuth(() {
    final auth = ref.read(firebaseAuthProvider);

    return auth.signOut();
  });
}
