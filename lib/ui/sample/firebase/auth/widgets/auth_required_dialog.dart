import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';

@immutable
class AuthRequiredDialog extends ConsumerWidget {
  const AuthRequiredDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return SelectionArea(
      child: AlertDialog(
        key: WidgetKeys.authRequiredDialog,
        title: Text(l10n.error),
        content: Text(l10n.authenticationRequired),
      ),
    );
  }
}
