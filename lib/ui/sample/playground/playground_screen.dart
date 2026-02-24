part of '../../../core/routing/router.dart';

class PlaygroundScreenRoute extends GoRouteData with $PlaygroundScreenRoute {
  static const path = '/playground';
  static const absolutePath = '/sample/playground';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PlaygroundScreen();
}

@immutable
class PlaygroundScreen extends HookConsumerWidget {
  const PlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return AppBarScope(
      state: AppBarState(title: Text(l10n.playground)),
      child: const Placeholder(),
    );
  }
}
