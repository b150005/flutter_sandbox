import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../config/l10n/app_localizations.dart';
import '../extensions/firebase_auth_exception.dart';
import '../logging/log_message.dart';
import '../logging/logger.dart';
import 'app_exception.dart';

class ExceptionHandler {
  const ExceptionHandler._();

  static Future<Result<T, AppException>> execute<T>(
    FutureOr<T> Function() operation, {
    required AppLocalizations l10n,
    FutureOr<void> Function()? precheck,
  }) async {
    try {
      await precheck?.call();

      final result = await operation();

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
}
