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
import '../../shared_preferences/shared_preferences_repository.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
User? currentUser(Ref ref) => ref.watch(firebaseAuthProvider).currentUser;

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
      // TODO(b150005): プラットフォームごとに以下の対応を実施する
      // @see https://docs.flutter.dev/ui/navigation/deep-linking
      // @see https://codewithandrea.com/articles/flutter-deep-links/
      // Web: 特になし
      // iOS/Android: Universal Links, App Linksの設定ファイルをホスティング
      // macOS/Windows: カスタムURLスキーマを設定(macOS: Info.plist, Windows: msix_config)
      url: Env.instance.origin + VerifyEmailScreenRoute.absolutePath,
    );

    await auth.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: actionCodeSettings,
    );

    await ref
        .read(sharedPreferencesRepositoryProvider)
        .setString(SharedPreferencesKeys.emailForSignIn.name, email);
  });

  /// メールリンク認証を用いてサインインを行う
  ///
  /// @see [Complete sign in with the email link](https://firebase.google.com/docs/auth/flutter/email-link-auth#complete_sign_in_with_the_email_link)
  Future<Result<UserCredential, AppException>> signInWithEmailLink({
    required String emailLink,
  }) => _executeWithFirebaseAuth(() async {
    final auth = ref.read(firebaseAuthProvider);
    final l10n = ref.read(appLocalizationsProvider);

    if (!auth.isSignInWithEmailLink(emailLink)) {
      throw AppException.badRequest(l10n.invalidVerificationEmailLink);
    }

    final email = await ref
        .read(sharedPreferencesRepositoryProvider)
        .getString(SharedPreferencesKeys.emailForSignIn.name);

    if (email == null) {
      throw AppException.notFound(l10n.sharedPreferencesKeyNotFound);
    }

    return auth.signInWithEmailLink(email: email, emailLink: emailLink);
  });

  /// メールアドレスとパスワードを用いてユーザを作成する
  ///
  /// @see [Create a user](https://firebase.google.com/docs/auth/flutter/manage-users#create_a_user)
  Future<Result<UserCredential, AppException>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) => _executeWithFirebaseAuth(() {
    final auth = ref.read(firebaseAuthProvider);

    return auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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
}
