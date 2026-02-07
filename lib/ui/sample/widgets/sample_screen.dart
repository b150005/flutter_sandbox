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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final contents = ref.watch(sampleContentsProvider);

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
