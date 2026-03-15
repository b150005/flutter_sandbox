import 'package:firebase_auth/firebase_auth.dart';

import '../../config/firebase/firebase_error_code.dart';
import '../../config/l10n/app_localizations.dart';
import '../exceptions/app_exception.dart';
import '../logging/log_message.dart';
import '../logging/logger.dart';

extension FirebaseAuthExceptionExtension on FirebaseAuthException {
  AppException toAppException(AppLocalizations l10n) {
    switch (code) {
      case FirebaseErrorCode.invalidEmail:
        return .badRequest(l10n.invalidEmailFormat);
      case FirebaseErrorCode.emailAlreadyInUse:
        return .conflict(l10n.registeredEmail);
      case FirebaseErrorCode.userDisabled:
        return .forbidden(l10n.accountDisabled);
      case FirebaseErrorCode.userNotFound:
        return .notFound(l10n.authenticationFailed);
      case FirebaseErrorCode.weakPassword:
        return .upgradeRequired(l10n.weakPassword);
      case FirebaseErrorCode.wrongPassword:
        return .unauthorized(l10n.invalidEmailOrPassword);
      case FirebaseErrorCode.tooManyRequests || FirebaseErrorCode.quotaExceeded:
        return .tooManyRequests(l10n.tooManyAttempts);
      case FirebaseErrorCode.userTokenExpired:
        return .unauthorized(l10n.sessionExpired);
      case FirebaseErrorCode.networkRequestFailed:
        return .serviceUnavailable(l10n.networkConnectionError);
      case FirebaseErrorCode.invalidLoginCredentials ||
          FirebaseErrorCode.invalidCredential:
        return .unauthorized(l10n.authenticationFailed);
      case FirebaseErrorCode.invalidActionCode ||
          FirebaseErrorCode.firebaseAppCheckTokenIsInvalid:
        return .badRequest(l10n.authenticationFailed);
      case FirebaseErrorCode.operationNotAllowed:
        return .forbidden(l10n.authenticationFailed);
      default:
        Logger.instance.w(LogMessage.unimplementedCode(code));
        Logger.instance.w(message);

        return .unknown(l10n.authenticationFailed);
    }
  }

  String toLocalizedMessage(AppLocalizations l10n) =>
      toAppException(l10n).message;

  bool get isInvalidAppCheckToken =>
      code == FirebaseErrorCode.firebaseAppCheckTokenIsInvalid;
}
