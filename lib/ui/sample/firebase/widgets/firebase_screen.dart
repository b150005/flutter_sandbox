part of '../../../../core/routing/router.dart';

class FirebaseScreenRoute extends GoRouteData with $FirebaseScreenRoute {
  static const path = '/firebase';
  static const absolutePath = '/sample/firebase';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FirebaseScreen();
}

@immutable
class FirebaseScreen extends HookConsumerWidget {
  const FirebaseScreen({super.key});

  static List<Content> _contents(l10n.AppLocalizations l10n) => [
        Content(
          path: FirebaseAuthScreenRoute.absolutePath,
          title: 'Auth',
          description: l10n.authScreenDescription,
          subtitle: 'Firebase Auth',
        ),
        Content(
          path: DataConnectScreenRoute.absolutePath,
          title: 'Data Connect',
          description: l10n.dataConnectScreenDescription,
          subtitle: 'Firebase Data Connect',
        ),
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final contents = useMemoized(() => _contents(l10n), [l10n]);

    return AppBarScope(
      state: AppBarState(title: Text(l10n.firebase)),
      child: GridView.extent(
        maxCrossAxisExtent: GridDimensions.maxCrossAxisExtent,
        children: contents
            .map((content) => ContentCard(content: content))
            .toList(),
      ),
    );
  }
}
