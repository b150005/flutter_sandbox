part of '../../../core/routing/router.dart';

enum SampleContent {
  firebase(
    path: FirebaseScreenRoute.absolutePath,
    title: 'Firebase',
    subtitle: 'Firebase Login',
  ),
  localStorage(
    path: LocalStorageScreenRoute.absolutePath,
    title: 'Local Storage',
    subtitle: 'Local Storage Sandbox',
  );

  const SampleContent({
    required this.path,
    required this.title,
    this.subtitle,
    // ignore: unused_element_parameter
    this.thumbnailPath,
  });

  final String path;
  final String title;
  final String? subtitle;
  final String? thumbnailPath;

  String description(l10n.AppLocalizations l10n) {
    return switch (this) {
      firebase => l10n.loginScreenDescription,
      localStorage => l10n.localStorageScreenDescription,
    };
  }
}

class SampleScreenRoute extends GoRouteData with $SampleScreenRoute {
  static const path = '/sample';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SampleScreen();
}

class SampleScreen extends HookConsumerWidget {
  const SampleScreen({super.key});

  static const double maxCrossAxisExtent = 480;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contents = ref.watch(sampleContentsProvider);

    return GridView.extent(
      maxCrossAxisExtent: maxCrossAxisExtent,
      children: contents
          .map((content) => ContentCard(content: content))
          .toList(),
    );
  }
}
