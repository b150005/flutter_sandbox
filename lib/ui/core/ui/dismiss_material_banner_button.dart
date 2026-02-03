import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/constants/widget_keys.dart';
import '../../../core/utils/l10n/app_localizations.dart';
import 'utils/app_messenger.dart';

@immutable
class DismissMaterialBannerButton extends ConsumerWidget {
  const DismissMaterialBannerButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return TextButton(
      key: WidgetKeys.dismiss,
      onPressed: () => AppMessenger.hideMaterialBanner(
        reason: MaterialBannerClosedReason.dismiss,
      ),
      child: Text(l10n.ok),
    );
  }
}
