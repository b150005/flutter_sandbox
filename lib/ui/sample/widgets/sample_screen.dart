part of '../../../core/routing/router.dart';

enum SampleContent {
  firebase(
    path: FirebaseScreenRoute.absolutePath,
    title: 'Firebase',
    subtitle: 'Firebase Login',
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
    };
  }
}

class SampleScreenRoute extends GoRouteData with _$SampleScreenRoute {
  static const path = '/sample';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SampleScreen();
}

class SampleScreen extends HookConsumerWidget {
  const SampleScreen({super.key});

  static const sliderWidthRatio = 0.6;
  static const maxPadding = 100.0;
  static const minMaxCrossAxisExtent = 240.0;
  static const maxMaxCrossAxisExtent = 500.0;
  static const maxMainAxisSpacing = 100.0;
  static const maxCrossAxisSpacing = 100.0;
  static const minChildAspectRatio = 0.01;
  static const maxCacheExtent = 1000.0;
  static const maxSemanticChildCount = 10.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reverse = useState<bool>(false);
    final controller = useState<ScrollController?>(null);
    final primary = useState<bool?>(null);
    final physics = useState<ScrollPhysics?>(null);
    final shrinkWrap = useState<bool>(false);
    final padding = useState<double>(8);
    final maxCrossAxisExtent = useState<double>(300);
    final mainAxisSpacing = useState<double>(0);
    final crossAxisSpacing = useState<double>(0);
    final childAspectRatio = useState<double>(1);
    final addAutomaticKeepAlives = useState<bool>(true);
    final addRepaintBoundaries = useState<bool>(true);
    final addSemanticIndexes = useState<bool>(true);
    final cacheExtent = useState<double?>(null);
    final semanticChildCount = useState<int?>(null);
    final dragStartBehavior = useState<DragStartBehavior>(
      DragStartBehavior.start,
    );
    final keyboardDismissBehavior =
        useState<ScrollViewKeyboardDismissBehavior?>(null);
    final clipBehavior = useState<Clip>(Clip.hardEdge);
    final hitTestBehavior = useState<HitTestBehavior>(HitTestBehavior.opaque);

    final gridViewOptions = [
      GridViewSettingsOption(title: 'reverse', valueNotifier: reverse),
      GridViewSettingsOption(
        title: 'controller',
        valueNotifier: controller,
        hintText: 'Select ScrollController',
      ),
      GridViewSettingsOption(
        title: 'primary(default: null)',
        valueNotifier: primary,
      ),
      GridViewSettingsOption(
        title: 'physics',
        valueNotifier: physics,
        hintText: 'Select ScrollPhysics',
      ),
      GridViewSettingsOption(
        title: 'padding',
        valueNotifier: padding,
        max: maxPadding,
      ),
      GridViewSettingsOption(
        title: 'maxCrossAxisExtent',
        valueNotifier: maxCrossAxisExtent,
        min: minMaxCrossAxisExtent,
        max: maxMaxCrossAxisExtent,
      ),
      GridViewSettingsOption(
        title: 'mainAxisSpacing',
        valueNotifier: mainAxisSpacing,
        max: maxMainAxisSpacing,
      ),
      GridViewSettingsOption(
        title: 'crossAxisSpacing',
        valueNotifier: crossAxisSpacing,
        max: maxCrossAxisSpacing,
      ),
      GridViewSettingsOption(
        title: 'childAspectRatio',
        valueNotifier: childAspectRatio,
        min: minChildAspectRatio,
      ),
      GridViewSettingsOption(
        title: 'addAutomaticKeepAlives',
        valueNotifier: addAutomaticKeepAlives,
      ),
      GridViewSettingsOption(
        title: 'addRepaintBoundaries',
        valueNotifier: addRepaintBoundaries,
      ),
      GridViewSettingsOption(
        title: 'addSemanticIndexes',
        valueNotifier: addSemanticIndexes,
      ),
      GridViewSettingsOption(
        title: 'cacheExtent',
        valueNotifier: cacheExtent,
        max: maxCacheExtent,
      ),
      GridViewSettingsOption(
        title: 'semanticChildCount',
        valueNotifier: semanticChildCount,
        max: maxSemanticChildCount,
      ),
      GridViewSettingsOption(
        title: 'dragStartBehavior',
        valueNotifier: dragStartBehavior,
        hintText: 'Select DragStartBehavior',
      ),
      GridViewSettingsOption(
        title: 'keyboardDismissBehavior',
        valueNotifier: keyboardDismissBehavior,
        hintText: 'Select ScrollViewKeyboardDismissBehavior',
      ),
      GridViewSettingsOption(
        title: 'clipBehavior',
        valueNotifier: clipBehavior,
        hintText: 'Select Clip',
      ),
      GridViewSettingsOption(
        title: 'hitTestBehavior',
        valueNotifier: hitTestBehavior,
        hintText: 'Select HitTestBehavior',
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: GridViewSettingsExpansionTile(
              options: gridViewOptions,
              onControllerChanged: ({controller}) {
                if (controller != null && primary.value == true) {
                  primary.value = null;
                }
              },
              onPrimaryChanged: ({primary}) {
                if (primary == true && controller.value != null) {
                  controller.value = null;
                }
              },
            ),
          ),
        ),
        Expanded(
          child: GridView.extent(
            reverse: reverse.value,
            controller: controller.value,
            primary: primary.value,
            physics: physics.value,
            shrinkWrap: shrinkWrap.value,
            padding: EdgeInsets.all(padding.value),
            maxCrossAxisExtent: maxCrossAxisExtent.value,
            mainAxisSpacing: mainAxisSpacing.value,
            crossAxisSpacing: crossAxisSpacing.value,
            childAspectRatio: childAspectRatio.value,
            addAutomaticKeepAlives: addAutomaticKeepAlives.value,
            addRepaintBoundaries: addRepaintBoundaries.value,
            addSemanticIndexes: addSemanticIndexes.value,
            cacheExtent: cacheExtent.value,
            semanticChildCount: semanticChildCount.value,
            dragStartBehavior: dragStartBehavior.value,
            keyboardDismissBehavior: keyboardDismissBehavior.value,
            clipBehavior: clipBehavior.value,
            hitTestBehavior: hitTestBehavior.value,
            children: SampleContent.values
                .map((content) => SampleContentCard(content: content))
                .toList(),
          ),
        ),
      ],
    );
  }
}
