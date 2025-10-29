import 'package:flutter/material.dart';
import 'package:hooks_riverpod/experimental/mutation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as hooks;
import 'package:hooks_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'logger.dart';

@immutable
final class ProviderObserver extends hooks.ProviderObserver {
  @override
  void didAddProvider(hooks.ProviderObserverContext context, Object? value) {
    Logger.instance.t(
      '🚀 ${_formatProvider(context.provider)} was initialized'
      ' with ${_formatValue(value)}',
    );
  }

  @override
  void didDisposeProvider(hooks.ProviderObserverContext context) {
    Logger.instance.t('🗑️ ${_formatProvider(context.provider)} was disposed');
  }

  @override
  void didUpdateProvider(
    hooks.ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    Logger.instance.t(
      '✅ ${_formatProvider(context.provider)} updated:'
      ' ${_formatValue(previousValue)} => ${_formatValue(newValue)}',
    );
  }

  @override
  void providerDidFail(
    hooks.ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    Logger.instance.t(
      '❌ ${_formatProvider(context.provider)} threw $error',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void mutationStart(
    hooks.ProviderObserverContext context,
    Mutation<Object?> mutation,
  ) {
    Logger.instance.t(
      '▶️ ${_formatProvider(context.provider)} invoked'
      ' ${mutation.label}',
    );
  }

  @override
  void mutationReset(
    hooks.ProviderObserverContext context,
    Mutation<Object?> mutation,
  ) {
    Logger.instance.t(
      '🔄 ${_formatProvider(context.provider)} reset'
      ' ${mutation.label}',
    );
  }

  @override
  void mutationSuccess(
    hooks.ProviderObserverContext context,
    Mutation<Object?> mutation,
    Object? result,
  ) {
    Logger.instance.t(
      '✅ ${mutation.label} invoked by'
      ' ${_formatProvider(context.provider)} succeeded',
    );
  }

  @override
  void mutationError(
    hooks.ProviderObserverContext context,
    Mutation<Object?> mutation,
    Object error,
    StackTrace stackTrace,
  ) {
    Logger.instance.t(
      '❌ ${mutation.label} invoked by'
      ' ${_formatProvider(context.provider)} threw $error',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// ログ出力用に整形された Provider の情報を取得する
  static String _formatProvider(ProviderBase<Object?> provider) {
    final name = provider.name ?? provider.toString();

    return '$name [${provider.runtimeType}]';
  }

  /// ログ出力用に整形された Object の情報を取得する
  static String _formatValue(Object? object) => switch (object) {
    AsyncError(:final error) => error.runtimeType.toString(),
    _ => object.toString(),
  };
}
