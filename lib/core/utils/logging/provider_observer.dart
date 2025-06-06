import 'package:hooks_riverpod/hooks_riverpod.dart' as hooks;
import 'package:hooks_riverpod/misc.dart' show ProviderBase;

import 'logger.dart';

class ProviderObserver extends hooks.ProviderObserver {
  @override
  void didAddProvider(hooks.ProviderObserverContext context, Object? value) {
    Logger.instance.t(
      '🚀 ${_formatProvider(context.provider)} was initialized with $value',
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
      ' $previousValue => $newValue',
    );
  }

  @override
  void providerDidFail(
    hooks.ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    Logger.instance.t(
      '❌ ${_formatProvider(context.provider)} threw $error at $stackTrace',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void mutationStart(
    hooks.ProviderObserverContext context,
    hooks.MutationContext mutation,
  ) {
    Logger.instance.t(
      '▶️ ${_formatProvider(context.provider)} invoked'
      ' ${_formatInvocation(mutation.invocation)}',
    );
  }

  @override
  void mutationReset(hooks.ProviderObserverContext context) {
    Logger.instance.t(
      '🔄 ${_formatProvider(context.provider)} reset'
      ' ${_formatInvocation(context.mutation?.invocation)}',
    );
  }

  @override
  void mutationSuccess(
    hooks.ProviderObserverContext context,
    hooks.MutationContext mutation,
    Object? result,
  ) {
    Logger.instance.t(
      '✅ ${_formatInvocation(mutation.invocation)} invoked by'
      ' ${_formatProvider(context.provider)} succeeded',
    );
  }

  @override
  void mutationError(
    hooks.ProviderObserverContext context,
    hooks.MutationContext mutation,
    Object error,
    StackTrace stackTrace,
  ) {
    Logger.instance.t(
      '❌ ${_formatInvocation(mutation.invocation)} invoked by'
      ' ${_formatProvider(context.provider)} threw $error at $stackTrace',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// ログ出力用に整形された Provider の情報を取得する
  static String _formatProvider(ProviderBase<Object?> provider) {
    final name = provider.name ?? provider.toString();

    return '$name [${provider.runtimeType}]';
  }

  /// ログ出力ように整形された Invocation の情報を取得する
  static String _formatInvocation(Invocation? invocation) {
    if (invocation == null) {
      return invocation.toString();
    }

    final method = invocation.memberName.toString();
    final args = invocation.positionalArguments.join(', ');

    return '$method($args)';
  }
}
