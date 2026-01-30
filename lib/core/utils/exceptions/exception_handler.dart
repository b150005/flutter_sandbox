import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../config/l10n/app_localizations.dart';
import '../extensions/firebase_auth_exception.dart';
import '../logging/log_message.dart';
import '../logging/logger.dart';
import 'app_exception.dart';

abstract final class ExceptionHandler {
  const ExceptionHandler._();

  static Result<T, AppException> execute<T>(
    T Function() operation, {
    required AppLocalizations l10n,
    VoidCallback? precheck,
  }) {
    try {
      precheck?.call();

      final result = operation();

      return Result.success(result);
    } on AppException catch (error) {
      return Result.error(error);
    } on FirebaseAuthException catch (error, stackTrace) {
      Logger.instance.e(error.message, error: error, stackTrace: stackTrace);

      return Result.error(error.toAppException(l10n));
    } on Exception catch (error, stackTrace) {
      Logger.instance.e(
        LogMessage.unhandledError(error),
        error: error,
        stackTrace: stackTrace,
      );

      return const Result.error(AppException.unknown());
    }
  }

  static Future<Result<T, AppException>> executeAsync<T>(
    FutureOr<T> Function() operation, {
    required AppLocalizations l10n,
    FutureOr<void> Function()? precheck,
    FirebaseAppCheck? appCheck,
    bool refreshesAppCheckToken = true,
  }) async {
    try {
      await precheck?.call();

      final result = await operation();

      return Result.success(result);
    } on AppException catch (error) {
      return Result.error(error);
    } on FirebaseAuthException catch (error, stackTrace) {
      Logger.instance.e(error.message, error: error, stackTrace: stackTrace);

      final canRetry =
          error.isInvalidAppCheckToken &&
          appCheck != null &&
          refreshesAppCheckToken;

      if (canRetry) {
        Logger.instance.w(LogMessage.invalidAppCheckToken);

        await _refreshesAppCheckToken(appCheck);

        return executeAsync(
          operation,
          l10n: l10n,
          precheck: precheck,
          appCheck: appCheck,
          refreshesAppCheckToken: false,
        );
      }

      return Result.error(error.toAppException(l10n));
    } on Exception catch (error, stackTrace) {
      Logger.instance.e(
        LogMessage.unhandledError(error),
        error: error,
        stackTrace: stackTrace,
      );

      return const Result.error(AppException.unknown());
    }
  }

  static Future<void> _refreshesAppCheckToken(FirebaseAppCheck appCheck) async {
    try {
      await appCheck.getToken(true);

      Logger.instance.i(LogMessage.appCheckTokenRefreshSucceeded);
    } on Exception catch (error, stackTrace) {
      Logger.instance.e(
        LogMessage.appCheckTokenRefreshFailed,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
