part of '../../../core/routing/router.dart';

class SampleScreenRoute extends GoRouteData with _$SampleScreenRoute {
  static const path = '/sample';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SampleScreen();
}

class SampleScreen extends HookConsumerWidget {
  const SampleScreen({super.key});

  static const sliderWidthRatio = 0.6;
  static const maxPadding = 100;
  static const maxMaxCrossAxisExtent = 500;
  static const maxMainAxisSpacing = 100;
  static const maxCrossAxisSpacing = 100;
  static const minChildAspectRatio = 0.01;
  static const maxChildAspectRatio = 1.0;
  static const maxCacheExtent = 1000;
  static const maxSemanticChildCount = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reverse = useState<bool>(false);
    final controller = useState<ScrollController?>(null);
    final primary = useState<bool?>(null);
    final physics = useState<ScrollPhysics?>(null);
    final shrinkWrap = useState<bool>(false);
    final padding = useState<double>(8);
    final maxCrossAxisExtent = useState<double>(240);
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: ExpansionTile(
              title: const Text('GridView.extent'),
              children: [
                SwitchListTile.adaptive(
                  title: const Text('reverse'),
                  value: reverse.value,
                  onChanged: (isReversed) => reverse.value = isReversed,
                ),
                ListTile(
                  title: const Text('controller'),
                  trailing: DropdownMenu(
                    dropdownMenuEntries: _ScrollControllerDropdownMenuEntry
                        .values
                        .map(
                          (entry) => DropdownMenuEntry(
                            value: entry.controller,
                            label: entry.isDefault
                                ? '${entry.label} (default)'
                                : entry.label,
                            enabled: entry.enabled,
                          ),
                        )
                        .toList(),
                    initialSelection: controller.value,
                    onSelected: (selectedScrollController) {
                      controller.value?.dispose();
                      controller.value = selectedScrollController;
                    },
                    hintText: 'Select ScrollController',
                  ),
                ),
                SwitchListTile.adaptive(
                  title: const Text('primary(default: null)'),
                  value: primary.value ?? false,
                  onChanged: (isPrimary) => primary.value = isPrimary,
                ),
                ListTile(
                  title: const Text('physics'),
                  trailing: DropdownMenu(
                    dropdownMenuEntries: _PhysicsDropdownMenuEntry.values
                        .map(
                          (entry) => DropdownMenuEntry(
                            value: entry.value,
                            label: entry.isDefault
                                ? '${entry.label} (default)'
                                : entry.label,
                            enabled: entry.enabled,
                          ),
                        )
                        .toList(),
                    initialSelection: physics.value,
                    onSelected: (selectedPhysics) =>
                        physics.value = selectedPhysics,
                    hintText: 'Select ScrollPhysics',
                  ),
                ),
                SwitchListTile.adaptive(
                  title: const Text('shrinkWrap'),
                  value: shrinkWrap.value,
                  onChanged: (isShrinkWrap) => shrinkWrap.value = isShrinkWrap,
                ),
                ListTile(
                  title: const Text('padding'),
                  subtitle: Text(padding.value.toStringAsFixed(1)),
                  trailing: LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      width: constraints.maxWidth * sliderWidthRatio,
                      child: Slider.adaptive(
                        value: padding.value,
                        max: maxPadding.toDouble(),
                        onChanged: (value) => padding.value = value,
                        divisions: maxPadding,
                        label: padding.value.toString(),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('maxCrossAxisExtent'),
                  subtitle: Text(maxCrossAxisExtent.value.toStringAsFixed(1)),
                  trailing: LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      width: constraints.maxWidth * sliderWidthRatio,
                      child: Slider.adaptive(
                        value: maxCrossAxisExtent.value,
                        min: 50,
                        max: maxMaxCrossAxisExtent.toDouble(),
                        onChanged: (value) => maxCrossAxisExtent.value = value,
                        divisions: maxMaxCrossAxisExtent,
                        label: maxCrossAxisExtent.value.toString(),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('mainAxisSpacing'),
                  subtitle: Text(mainAxisSpacing.value.toStringAsFixed(1)),
                  trailing: LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      width: constraints.maxWidth * sliderWidthRatio,
                      child: Slider.adaptive(
                        value: mainAxisSpacing.value,
                        max: maxMainAxisSpacing.toDouble(),
                        onChanged: (value) => mainAxisSpacing.value = value,
                        divisions: maxMainAxisSpacing,
                        label: mainAxisSpacing.value.toString(),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('crossAxisSpacing'),
                  subtitle: Text(crossAxisSpacing.value.toStringAsFixed(1)),
                  trailing: LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      width: constraints.maxWidth * sliderWidthRatio,
                      child: Slider.adaptive(
                        value: crossAxisSpacing.value,
                        max: maxCrossAxisSpacing.toDouble(),
                        onChanged: (value) => crossAxisSpacing.value = value,
                        divisions: maxCrossAxisSpacing,
                        label: crossAxisSpacing.value.toString(),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('childAspectRatio'),
                  subtitle: Text(childAspectRatio.value.toStringAsFixed(2)),
                  trailing: LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      width: constraints.maxWidth * sliderWidthRatio,
                      child: Slider.adaptive(
                        value: childAspectRatio.value,
                        onChanged: (value) => childAspectRatio.value = value,
                        min: minChildAspectRatio,
                        divisions:
                            ((maxChildAspectRatio - minChildAspectRatio) /
                                    minChildAspectRatio)
                                .round(),
                        label: childAspectRatio.value.toString(),
                      ),
                    ),
                  ),
                ),
                SwitchListTile.adaptive(
                  title: const Text('addAutomaticKeepAlives'),
                  value: addAutomaticKeepAlives.value,
                  onChanged: (addsAutomaticKeepAlives) =>
                      addAutomaticKeepAlives.value = addsAutomaticKeepAlives,
                ),
                SwitchListTile.adaptive(
                  title: const Text('addRepaintBoundaries'),
                  value: addRepaintBoundaries.value,
                  onChanged: (addsRepaintBoundaries) =>
                      addRepaintBoundaries.value = addsRepaintBoundaries,
                ),
                SwitchListTile.adaptive(
                  title: const Text('addSemanticIndexes'),
                  value: addSemanticIndexes.value,
                  onChanged: (addsSemanticIndexes) =>
                      addSemanticIndexes.value = addsSemanticIndexes,
                ),
                ListTile(
                  title: const Text('cacheExtent'),
                  subtitle: Text(
                    cacheExtent.value?.toStringAsFixed(1) ?? 'null',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioMenuButton(
                        value: null,
                        groupValue: cacheExtent.value,
                        onChanged: (value) => cacheExtent.value = value,
                        child: const Text('null'),
                      ),
                      Flexible(
                        child: LayoutBuilder(
                          builder: (context, constraints) => SizedBox(
                            width: constraints.maxWidth * sliderWidthRatio,
                            child: Slider.adaptive(
                              value: cacheExtent.value ?? 0,
                              max: maxCacheExtent.toDouble(),
                              onChanged: (value) => cacheExtent.value = value,
                              divisions: maxCacheExtent,
                              label: cacheExtent.value.toString(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('semanticChildCount'),
                  subtitle: Text(semanticChildCount.value.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioMenuButton(
                        value: null,
                        groupValue: semanticChildCount.value,
                        onChanged: (value) => semanticChildCount.value = value,
                        child: const Text('null'),
                      ),
                      Flexible(
                        child: LayoutBuilder(
                          builder: (context, constraints) => SizedBox(
                            width: constraints.maxWidth * sliderWidthRatio,
                            child: Slider.adaptive(
                              value: semanticChildCount.value?.toDouble() ?? 0,
                              max: maxSemanticChildCount.toDouble(),
                              onChanged: (value) =>
                                  semanticChildCount.value = value.toInt(),
                              divisions: maxSemanticChildCount,
                              label: semanticChildCount.value.toString(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('dragStartBehavior'),
                  trailing: DropdownMenu(
                    dropdownMenuEntries: _DragStartBehaviorDropdownMenuEntry
                        .values
                        .map(
                          (entry) => DropdownMenuEntry(
                            value: entry.value,
                            label: entry.isDefault
                                ? '${entry.label} (default)'
                                : entry.label,
                          ),
                        )
                        .toList(),
                    initialSelection: dragStartBehavior.value,
                    onSelected: (selectedDragStartBehavior) =>
                        dragStartBehavior.value =
                            selectedDragStartBehavior ??
                            DragStartBehavior.start,
                    hintText: 'Select DragStartBehavior',
                  ),
                ),
                ListTile(
                  title: const Text('keyboardDismissBehavior'),
                  trailing: DropdownMenu(
                    dropdownMenuEntries:
                        _ScrollViewKeyboardDismissBehaviorDropdownMenuEntry
                            .values
                            .map(
                              (entry) => DropdownMenuEntry(
                                value: entry.value,
                                label: entry.isDefault
                                    ? '${entry.label} (default)'
                                    : entry.label,
                              ),
                            )
                            .toList(),
                    initialSelection: keyboardDismissBehavior.value,
                    onSelected: (selectedKeyboardDismissBehavior) =>
                        keyboardDismissBehavior.value =
                            selectedKeyboardDismissBehavior,
                    hintText: 'Select ScrollViewKeyboardDismissBehavior',
                  ),
                ),
                ListTile(
                  title: const Text('clipBehavior'),
                  trailing: DropdownMenu(
                    dropdownMenuEntries: _ClipDropdownMenuEntry.values
                        .map(
                          (entry) => DropdownMenuEntry(
                            value: entry.value,
                            label: entry.isDefault
                                ? '${entry.label} (default)'
                                : entry.label,
                          ),
                        )
                        .toList(),
                    initialSelection: clipBehavior.value,
                    onSelected: (selectedClipBehavior) => clipBehavior.value =
                        selectedClipBehavior ?? Clip.hardEdge,
                    hintText: 'Select Clip',
                  ),
                ),
                ListTile(
                  title: const Text('hitTestBehavior'),
                  trailing: DropdownMenu(
                    dropdownMenuEntries: _HitTestBehaviorDropdownMenuEntry
                        .values
                        .map(
                          (entry) => DropdownMenuEntry(
                            value: entry.value,
                            label: entry.isDefault
                                ? '${entry.label} (default)'
                                : entry.label,
                          ),
                        )
                        .toList(),
                    initialSelection: hitTestBehavior.value,
                    onSelected: (selectedHitTestBehavior) =>
                        hitTestBehavior.value =
                            selectedHitTestBehavior ?? HitTestBehavior.opaque,
                    hintText: 'Select HitTestBehavior',
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
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
            children: List.generate(
              10,
              (index) => Placeholder(child: Text(index.toString())),
            ),
          ),
        ),
      ],
    );
  }
}

enum _ScrollControllerDropdownMenuEntry {
  null_(label: 'null', isDefault: true),
  scrollController(controllerType: ScrollController, label: 'ScrollController'),
  trackingScrollController(
    controllerType: TrackingScrollController,
    label: 'TrackingScrollController',
  ),
  fixedExtentScrollController(
    controllerType: FixedExtentScrollController,
    label: 'FixedExtentScrollController',
    enabled: false,
  ),
  pageController(
    controllerType: PageController,
    label: 'PageController',
    enabled: false,
  );

  const _ScrollControllerDropdownMenuEntry({
    this.controllerType,
    required this.label,
    this.isDefault = false,
    this.enabled = true,
  });

  final Type? controllerType;
  final String label;
  final bool isDefault;
  final bool enabled;

  ScrollController? get controller => switch (controllerType) {
    const (ScrollController) => ScrollController(),
    const (TrackingScrollController) => TrackingScrollController(),
    const (FixedExtentScrollController) => FixedExtentScrollController(),
    const (PageController) => PageController(),
    _ => null,
  };
}

enum _PhysicsDropdownMenuEntry {
  null_(label: 'null', isDefault: true),
  alwaysScrollable(
    value: AlwaysScrollableScrollPhysics(),
    label: 'AlwaysScrollable',
  ),
  neverScrollable(
    value: NeverScrollableScrollPhysics(),
    label: 'NeverScrollable',
  ),
  bouncing(value: BouncingScrollPhysics(), label: 'Bouncing'),
  clamping(value: ClampingScrollPhysics(), label: 'Clamping'),
  fixedExtent(
    value: FixedExtentScrollPhysics(),
    label: 'FixedExtent',
    enabled: false,
  ),
  page(value: PageScrollPhysics(), label: 'Page'),
  rangeMaintaining(
    value: RangeMaintainingScrollPhysics(),
    label: 'RangeMaintaining',
  );

  const _PhysicsDropdownMenuEntry({
    this.value,
    required this.label,
    this.isDefault = false,
    this.enabled = true,
  });

  final ScrollPhysics? value;
  final String label;
  final bool isDefault;
  final bool enabled;
}

enum _DragStartBehaviorDropdownMenuEntry {
  down(value: DragStartBehavior.down, label: 'down'),
  start(value: DragStartBehavior.start, label: 'start', isDefault: true);

  const _DragStartBehaviorDropdownMenuEntry({
    required this.value,
    required this.label,
    this.isDefault = false,
  });

  final DragStartBehavior value;
  final String label;
  final bool isDefault;
}

enum _ScrollViewKeyboardDismissBehaviorDropdownMenuEntry {
  null_(label: 'null', isDefault: true),
  manual(value: ScrollViewKeyboardDismissBehavior.manual, label: 'manual'),
  onDrag(value: ScrollViewKeyboardDismissBehavior.onDrag, label: 'onDrag');

  const _ScrollViewKeyboardDismissBehaviorDropdownMenuEntry({
    this.value,
    required this.label,
    this.isDefault = false,
  });

  final ScrollViewKeyboardDismissBehavior? value;
  final String label;
  final bool isDefault;
}

enum _ClipDropdownMenuEntry {
  none(value: Clip.none, label: 'none'),
  hardEdge(value: Clip.hardEdge, label: 'hardEdge', isDefault: true),
  antiAlias(value: Clip.antiAlias, label: 'antiAlias'),
  antiAliasWithSaveLayer(
    value: Clip.antiAliasWithSaveLayer,
    label: 'antiAliasWithSaveLayer',
  );

  const _ClipDropdownMenuEntry({
    required this.value,
    required this.label,
    this.isDefault = false,
  });

  final Clip value;
  final String label;
  final bool isDefault;
}

enum _HitTestBehaviorDropdownMenuEntry {
  deferToChild(value: HitTestBehavior.deferToChild, label: 'deferToChild'),
  opaque(value: HitTestBehavior.opaque, label: 'opaque', isDefault: true),
  translucent(value: HitTestBehavior.translucent, label: 'translucent');

  const _HitTestBehaviorDropdownMenuEntry({
    required this.value,
    required this.label,
    this.isDefault = false,
  });

  final HitTestBehavior value;
  final String label;
  final bool isDefault;
}
