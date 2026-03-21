part of '../../../core/routing/router.dart';

class SampleScreenRoute extends GoRouteData with $SampleScreenRoute {
  static const path = '/sample';
  static const absolutePath = '/sample';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SampleScreen();
}

@immutable
class SampleScreen extends HookConsumerWidget {
  const SampleScreen({super.key});

  static List<Content> _contents(l10n.AppLocalizations l10n) => [
    Content(
      route: FirebaseScreenRoute(),
      title: 'Firebase',
      description: l10n.signInScreenDescription,
      subtitle: 'Firebase Sign-In',
    ),
    Content(
      route: LocalStorageScreenRoute(),
      title: 'Local Storage',
      description: l10n.localStorageScreenDescription,
      subtitle: 'Local Storage Sandbox',
    ),
    Content(
      route: PlaygroundScreenRoute(),
      title: 'Playground',
      description: l10n.playgroundScreenDescription,
      subtitle: 'Playground',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final contents = useMemoized(() => _contents(l10n), [l10n]);

    return AppBarScope(
      state: AppBarState(title: Text(l10n.sample)),
      child: GridView.extent(
        maxCrossAxisExtent: GridDimensions.maxCrossAxisExtent,
        children: contents
            .map((content) => ContentCard(content: content))
            .toList(),
      ),
    );
  }
}
