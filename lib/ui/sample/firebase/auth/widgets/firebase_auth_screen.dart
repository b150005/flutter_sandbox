part of '../../../../../core/routing/router.dart';

class FirebaseAuthScreenRoute extends GoRouteData
    with $FirebaseAuthScreenRoute {
  static const path = '/auth';
  static const absolutePath = '/sample/firebase/auth';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SelectionArea(child: FirebaseAuthScreen());
}

@immutable
class FirebaseAuthScreen extends HookConsumerWidget {
  const FirebaseAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final secureStorageRepository = ref.watch(
      secureStorageRepositoryProvider.notifier,
    );

    ref.listen(authRepositoryProvider, (previous, current) {
      current.whenData((user) async {
        final currentEmail = user?.email;
        final previousEmail = previous?.value?.email;

        if (currentEmail == previousEmail) {
          return;
        }

        final storedEmailReadingResult = await secureStorageRepository.read(
          key: SecureStorageKey.email.name,
        );

        await storedEmailReadingResult.whenSuccess((storedEmail) async {
          if (storedEmail != currentEmail) {
            await secureStorageRepository.write(
              key: SecureStorageKey.email.name,
              value: currentEmail,
              label: l10n.email,
            );

            AppMessenger.showMaterialBanner(
              MaterialBanner(
                content: Text(l10n.updateEmailSuccessfully),
                leading: const Icon(
                  Icons.check_circle_outline_outlined,
                ),
                actions: const [DismissMaterialBannerButton()],
              ),
            );
          }
        });
      });
    });

    return AppBarScope(
      state: AppBarState(title: Text(l10n.firebaseAuth)),
      child: AuthStateBuilder(
        builder: (user) => ScrollableContainer(
          child: Column(
            spacing: Spacing.sm.dp,
            children: [
              UserProfileCard(user: user),
              UserAuthDetailCard(user: user),
              const SignOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
