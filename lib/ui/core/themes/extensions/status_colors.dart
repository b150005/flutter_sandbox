import 'package:flutter/material.dart';

@immutable
class StatusColors extends ThemeExtension<StatusColors> {
  const StatusColors._({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.failed,
    required this.onFailed,
    required this.failedContainer,
    required this.onFailedContainer,
  });

  factory StatusColors.fromSeed({
    Color successSeedColor = Colors.green,
    Brightness brightness = Brightness.light,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: successSeedColor,
      brightness: brightness,
    );

    return StatusColors._(
      success: colorScheme.primary,
      onSuccess: colorScheme.onPrimary,
      successContainer: colorScheme.primaryContainer,
      onSuccessContainer: colorScheme.onPrimaryContainer,
      failed: colorScheme.error,
      onFailed: colorScheme.onError,
      failedContainer: colorScheme.errorContainer,
      onFailedContainer: colorScheme.onErrorContainer,
    );
  }

  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color failed;
  final Color onFailed;
  final Color failedContainer;
  final Color onFailedContainer;

  @override
  StatusColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? failed,
    Color? onFailed,
    Color? failedContainer,
    Color? onFailedContainer,
  }) => StatusColors._(
    success: success ?? this.success,
    onSuccess: onSuccess ?? this.onSuccess,
    successContainer: successContainer ?? this.successContainer,
    onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
    failed: failed ?? this.failed,
    onFailed: onFailed ?? this.onFailed,
    failedContainer: failedContainer ?? this.failedContainer,
    onFailedContainer: onFailedContainer ?? this.onFailedContainer,
  );

  @override
  StatusColors lerp(
    StatusColors? other,
    double t,
  ) => other is StatusColors
      ? StatusColors._(
          success: Color.lerp(success, other.success, t)!,
          onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
          successContainer: Color.lerp(
            successContainer,
            other.successContainer,
            t,
          )!,
          onSuccessContainer: Color.lerp(
            onSuccessContainer,
            other.onSuccessContainer,
            t,
          )!,
          failed: Color.lerp(failed, other.failed, t)!,
          onFailed: Color.lerp(onFailed, other.onFailed, t)!,
          failedContainer: Color.lerp(
            failedContainer,
            other.failedContainer,
            t,
          )!,
          onFailedContainer: Color.lerp(
            onFailedContainer,
            other.onFailedContainer,
            t,
          )!,
        )
      : this;
}
