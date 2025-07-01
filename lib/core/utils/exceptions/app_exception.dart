import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../logging/log_message.dart';

part 'app_exception.freezed.dart';

@freezed
sealed class AppException with _$AppException implements Exception {
  const factory AppException.badRequest(String message) = BadRequest;

  const factory AppException.unauthorized(String message) = Unauthorized;

  const factory AppException.forbidden(String message) = Forbidden;

  const factory AppException.notFound(String message) = NotFound;

  const factory AppException.requestTimeout(String message) = RequestTimeout;

  const factory AppException.conflict(String message) = Conflict;

  const factory AppException.unsupportedMediaType(String message) =
      UnsupportedMediaType;

  const factory AppException.upgradeRequired(String message) = UpgradeRequired;

  const factory AppException.tooManyRequests(String message) = TooManyRequests;

  const factory AppException.internalServerError(String message) =
      InternalServerError;

  const factory AppException.notImplemented(String message) = NotImplemented;

  const factory AppException.serviceUnavailable(String message) =
      ServiceUnavailable;

  const factory AppException.insufficientStorage(String message) =
      InsufficientStorage;

  const factory AppException.cancelledByDebounce([
    @Default(LogMessage.cancelledByDebounce) String message,
  ]) = CancelledByDebounce;

  const factory AppException.unknown([
    @Default(LogMessage.internalError) String message,
  ]) = Unknown;
}
