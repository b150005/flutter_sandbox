import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/constants/widget_keys.dart';
import '../../../../core/utils/l10n/app_localizations.dart';
import '../../../../data/repositories/firebase/auth/auth_repository.dart';

@immutable
class SignOutButton extends ConsumerWidget {
  const SignOutButton({super.key});

  factory SignOutButton.icon() => const _SignOutIconButton();

  factory SignOutButton.filled() => const _SignOutFilledButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider.notifier);
    final l10n = ref.watch(appLocalizationsProvider);

    return OutlinedButton.icon(
      key: key ?? WidgetKeys.signOut,
      onPressed: authRepository.signOut,
      icon: const Icon(Icons.logout_outlined),
      label: Text(l10n.signOut),
    );
  }
}

@immutable
class _SignOutIconButton extends SignOutButton {
  const _SignOutIconButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider.notifier);

    return IconButton.outlined(
      key: key ?? WidgetKeys.signOut,
      onPressed: authRepository.signOut,
      icon: const Icon(Icons.logout_outlined),
    );
  }
}

@immutable
class _SignOutFilledButton extends SignOutButton {
  const _SignOutFilledButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider.notifier);
    final l10n = ref.watch(appLocalizationsProvider);

    return FilledButton.icon(
      onPressed: authRepository.signOut,
      icon: const Icon(Icons.logout_outlined),
      label: Text(l10n.signOut),
    );
  }
}
