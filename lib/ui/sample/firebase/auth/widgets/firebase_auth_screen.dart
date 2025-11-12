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
    final firebaseAuth = ref.watch(firebaseAuthProvider);

    useAppBar(
      ref,
      path: FirebaseAuthScreenRoute.absolutePath,
      state: AppBarState(title: Text(l10n.firebaseAuth)),
    );

    final secureStorageRepository = ref.watch(
      secureStorageRepositoryProvider.notifier,
    );
    final currentEmail = firebaseAuth.currentUser?.email;

    useEffect(
      () {
        Future.microtask(() async {
          final storedEmailReadingResult = await secureStorageRepository.read(
            key: SecureStorageKey.email.name,
          );

          await storedEmailReadingResult.whenSuccess((email) async {
            if (email != currentEmail) {
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

        return null;
      },
      [currentEmail],
    );

    return ScrollableContainer(
      child: Column(
        spacing: Spacing.sm.dp,
        children: const [
          UserProfileCard(),
          UserAuthDetailCard(),
          SignOutButton(),
        ],
      ),
    );
  }
}
