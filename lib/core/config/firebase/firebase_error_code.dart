/// FirebaseException のエラーコード
final class FirebaseErrorCode {
  const FirebaseErrorCode._();

  /// メールアドレスの形式が不正である
  static const invalidEmail = 'invalid-email';

  /// メールアドレスがすでに使用されている
  static const emailAlreadyInUse = 'email-already-in-use';

  /// 管理者によってユーザが無効化されている
  static const userDisabled = 'user-disabled';

  /// アカウント情報が見つからない
  static const userNotFound = 'user-not-found';

  /// パスワードに脆弱性がある
  static const weakPassword = 'weak-password';

  /// パスワードが間違っている
  static const wrongPassword = 'wrong-password';

  /// 試行回数が上限に達した
  static const tooManyRequests = 'too-many-requests';

  /// リフレッシュトークンの有効期限が切れている
  static const userTokenExpired = 'user-token-expired';

  /// ネットワーク接続に失敗した
  static const networkRequestFailed = 'network-request-failed';

  /// パスワードに問題がある
  static const invalidCredential = 'invalid-credential';

  /// パスワードに問題がある
  ///
  /// @see [invalidCredential]
  static const invalidLoginCredentials = 'INVALID_LOGIN_CREDENTIALS';

  /// アクションコードが無効である
  static const invalidActionCode = 'invalid-action-code';

  /// 利用上限に達した
  static const quotaExceeded = 'quota-exceeded';

  /// Firebase プロジェクトで有効化されていない認証方式である
  static const operationNotAllowed = 'operation-not-allowed';
}
