part of '../../../core/routing/router.dart';

class SampleScreenRoute extends GoRouteData with $SampleScreenRoute {
  static const path = '/sample';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SampleScreen();
}

@immutable
class SampleScreen extends HookConsumerWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAtSampleScreen = context.isAt(SampleScreenRoute.path);

    final l10n = ref.watch(appLocalizationsProvider);

    useEffect(() {
      if (isAtSampleScreen) {
        Future.microtask(
          () => ref
              .read(appBarStateProvider.notifier)
              .update(
                AppBarState(
                  title: Text(l10n.sample),
                ),
              ),
        );
      }

      return null;
    }, [isAtSampleScreen]);

    final contents = ref.watch(sampleContentsProvider);

    return GridView.extent(
      maxCrossAxisExtent: GridDimensions.maxCrossAxisExtent,
      children: contents
          .map((content) => ContentCard(content: content))
          .toList(),
    );
  }
}
