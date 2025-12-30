import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/exceptions/app_exception.dart';
import '../../../../core/utils/logging/log_message.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../extensions/build_context.dart';
import '../retry_button.dart';

@immutable
class AuthStateBuilder extends ConsumerWidget {
  const AuthStateBuilder({super.key, required this.builder, this.fallback});

  final Widget Function(User user) builder;
  final Widget? fallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authRepositoryProvider);

    return authState.when<Widget>(
      data: (user) {
        if (user == null) {
          Logger.instance.i(LogMessage.nullObject('user'));

          return fallback ??
              RetryButton(
                onPressed: () => ref.invalidate(authRepositoryProvider),
              );
        }

        return builder(user);
      },
      error: (error, stackTrace) {
        if (error is! AppException) {
          Logger.instance.e(
            LogMessage.unhandledError(error),
            error: error,
            stackTrace: stackTrace,
          );
        }

        return RetryButton(
          onPressed: () => ref.invalidate(authRepositoryProvider),
        );
      },
      loading: () => context.loadingIndicator,
    );
  }
}
