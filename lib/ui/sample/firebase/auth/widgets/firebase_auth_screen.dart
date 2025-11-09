part of '../../../../../core/routing/router.dart';

class FirebaseAuthScreenRoute extends GoRouteData
    with $FirebaseAuthScreenRoute {
  static const path = '/auth';
  static const absolutePath = '/sample/firebase/auth';
  static const emailUpdated = 'emailUpdated';

  static String emailUpdateUrl(String origin) => Uri.parse(
    origin + FirebaseAuthScreenRoute.absolutePath,
  ).replace(queryParameters: {emailUpdated: true.toString()}).toString();

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

    useAppBar(
      ref,
      path: FirebaseAuthScreenRoute.absolutePath,
      state: AppBarState(title: Text(l10n.firebaseAuth)),
    );

    final emailUpdated = BoolParser.tryParse(
      context
          .routerState
          .uri
          .queryParameters[FirebaseAuthScreenRoute.emailUpdated]
          .orNullString(
            objectName:
                'context.routerState.uri.queryParameters['
                '${FirebaseAuthScreenRoute.emailUpdated}'
                ']',
          ),
    ).orFalse();

    useEffect(
      () {
        if (emailUpdated) {
          Future.microtask(
            () => AppMessenger.showMaterialBanner(
              MaterialBanner(
                content: Text(l10n.updateEmailSuccessfully),
                leading: const Icon(Icons.check_circle_outline_outlined),
                actions: const [DismissMaterialBannerButton()],
              ),
            ),
          );
        }

        return null;
      },
      [emailUpdated],
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
