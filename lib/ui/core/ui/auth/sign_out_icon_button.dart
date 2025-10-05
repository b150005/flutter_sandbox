import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/repositories/firebase/auth/auth_repository.dart';

@Preview(name: 'Sign Out Icon Button')
Widget signOutIconButton() => const ProviderScope(child: SignOutIconButton());

@immutable
class SignOutIconButton extends ConsumerWidget {
  const SignOutIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider.notifier);

    return IconButton.outlined(
      key: key,
      onPressed: authRepository.signOut,
      icon: const Icon(Icons.logout_rounded),
    );
  }
}
