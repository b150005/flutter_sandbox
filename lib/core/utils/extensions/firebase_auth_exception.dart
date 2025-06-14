import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/firebase/error_code.dart';
import '../exceptions/app_exception.dart';
import '../l10n/app_localizations.dart';
import '../logging/logger.dart';

extension FirebaseAuthExceptionExtension on FirebaseAuthException {
  AppException toAppException(Ref ref) {
    final l10n = ref.read(appLocalizationsProvider);

    switch (code) {
      case ErrorCode.invalidEmail:
        return AppException.badRequest(l10n.errorInvalidEmailFormat);
      case ErrorCode.emailAlreadyInUse:
        return AppException.conflict(l10n.errorEmailAlreadyInUse);
      case ErrorCode.userDisabled:
        return AppException.forbidden(l10n.errorAccountDisabled);
      case ErrorCode.userNotFound:
        return AppException.notFound(l10n.errorInvalidEmailOrPassword);
      case ErrorCode.weakPassword:
        return AppException.upgradeRequired(l10n.errorWeakPassword);
      case ErrorCode.wrongPassword:
        return AppException.unauthorized(l10n.errorInvalidEmailOrPassword);
      case ErrorCode.tooManyRequests:
        return AppException.tooManyRequests(l10n.errorTooManyAttempts);
      case ErrorCode.userTokenExpired:
        return AppException.unauthorized(l10n.errorSessionExpired);
      case ErrorCode.networkRequestFailed:
        return AppException.serviceUnavailable(l10n.errorNetworkConnection);
      case ErrorCode.invalidLoginCredentials || ErrorCode.invalidCredential:
        return AppException.unauthorized(l10n.errorAuthenticationFailed);
      case ErrorCode.operationNotAllowed:
        return AppException.forbidden(l10n.errorAuthenticationFailed);
      default:
        Logger.instance.w(message);

        return AppException.unknown(l10n.errorAuthenticationFailed);
    }
  }

  String toLocalizedMessage(Ref ref) => toAppException(ref).message;
}
