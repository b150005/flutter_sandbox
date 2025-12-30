import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/env/env.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/utils/exceptions/app_exception.dart';
import '../../../../core/utils/exceptions/exception_handler.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../../../core/utils/logging/log_message.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../../core/utils/url/origin_resolver.dart';
import '../../secure_storage/secure_storage_repository.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
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
  ) => ExceptionHandler.executeAsync(
    operation,
    l10n: ref.read(appLocalizationsProvider),
    precheck: _ensureFirebaseInitialized,
  );

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

    final secureStorageRepository = ref.read(
      secureStorageRepositoryProvider.notifier,
    );
    final l10n = ref.read(appLocalizationsProvider);

    await secureStorageRepository.write(
      key: SecureStorageKey.email.name,
      value: email,
      label: l10n.email,
    );

    await auth.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: actionCodeSettings,
    );
  });

  /// メールリンク認証を用いてサインインを行う
  ///
  /// @see [Complete sign in with the email link](https://firebase.google.com/docs/auth/flutter/email-link-auth#complete_sign_in_with_the_email_link)
  Future<Result<UserCredential, AppException>> signInWithEmailLink({
    String? email,
    required Uri emailLink,
  }) => _executeWithFirebaseAuth(() async {
    final auth = ref.read(firebaseAuthProvider);
    final l10n = ref.read(appLocalizationsProvider);

    if (!auth.isSignInWithEmailLink(emailLink.toString())) {
      throw AppException.badRequest(l10n.invalidVerificationEmailLink);
    }

    final secureStorageRepository = ref.read(
      secureStorageRepositoryProvider.notifier,
    );

    if (email != null) {
      final emailWritingResult = await secureStorageRepository.write(
        key: SecureStorageKey.email.name,
        value: email,
        label: l10n.email,
      );

      emailWritingResult.whenError((appException) => throw appException);
    }

    final storedEmailReadingResult = await secureStorageRepository.read(
      key: SecureStorageKey.email.name,
    );
    final storedEmail = storedEmailReadingResult.when(
      (email) => email,
      (appException) => throw appException,
    );

    if (storedEmail == null) {
      throw AppException.notFound(l10n.notFound);
    }

    return auth.signInWithEmailLink(
      email: storedEmail,
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

  /// 電話番号を更新する
  Future<Result<void, AppException>> updatePhoneNumber({
    required PhoneAuthCredential phoneCredential,
  }) => _executeWithFirebaseAuth(() {
    final auth = ref.read(firebaseAuthProvider);
    final l10n = ref.read(appLocalizationsProvider);

    if (auth.currentUser == null) {
      throw AppException.unauthorized(l10n.authenticationFailed);
    }

    return auth.currentUser!.updatePhoneNumber(phoneCredential);
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
        .read(secureStorageRepositoryProvider.notifier)
        .write(key: SecureStorageKey.email.name, value: email);

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
      url: OriginResolver.current + FirebaseAuthScreenRoute.absolutePath,
    );

    return auth.currentUser!.verifyBeforeUpdateEmail(
      email,
      actionCodeSettings,
    );
  });

  /// 電話番号の認証コードを送信する
  Future<Result<void, AppException>> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(Result<void, AppException> result)
    onPhoneNumberUpdated,
    required void Function(AppException appException) onVerificationFailed,
    required void Function(String verificationId, int? forceResendingToken)
    onCodeSent,
    required void Function(String verificationId) onAutoRetrievalTimeout,
  }) => _executeWithFirebaseAuth(() {
    final auth = ref.read(firebaseAuthProvider);
    final l10n = ref.read(appLocalizationsProvider);

    if (auth.currentUser == null) {
      throw AppException.unauthorized(l10n.authenticationRequired);
    }

    return auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneCredential) async {
        final updateResult = await updatePhoneNumber(
          phoneCredential: phoneCredential,
        );

        onPhoneNumberUpdated(updateResult);
      },
      verificationFailed: (firebaseAuthException) =>
          ExceptionHandler.execute<void>(
            () => throw firebaseAuthException,
            l10n: l10n,
          ).whenError(onVerificationFailed),
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onAutoRetrievalTimeout,
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
