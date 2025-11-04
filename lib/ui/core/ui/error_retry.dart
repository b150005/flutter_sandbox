import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/icon_size.dart';
import '../../../core/config/constants/spacing.dart';
import '../../../core/config/constants/widget_keys.dart';
import '../../../core/utils/l10n/app_localizations.dart';
import '../extensions/build_context.dart';

@immutable
class ErrorRetry extends ConsumerWidget {
  const ErrorRetry({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return Column(
      key: WidgetKeys.errorRetry,
      spacing: Spacing.md.dp,
      children: [
        Icon(
          Icons.error_outline,
          size: IconSize.lg.dp,
          color: context.colorScheme.error,
        ),
        Text(l10n.tryAgain),
        OutlinedButton.icon(
          onPressed: onPressed,
          label: Text(l10n.retry),
          icon: const Icon(Icons.refresh_outlined),
        ),
      ],
    );
  }
}
