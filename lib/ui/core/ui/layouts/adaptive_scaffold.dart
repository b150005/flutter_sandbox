import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/constants/spacing.dart';
import '../../../../core/config/policies/design_policy.dart';
import '../../../../core/utils/l10n/app_localizations.dart';

@immutable
class _Destination {
  const _Destination({required this.icon, required this.label});

  final Icon icon;
  final String label;
}

@immutable
class AdaptiveScaffold extends ConsumerWidget {
  const AdaptiveScaffold({
    super.key,
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final destinations = [
      _Destination(icon: const Icon(Icons.home), label: l10n.home),
      _Destination(icon: const Icon(Icons.science), label: l10n.sample),
      _Destination(icon: const Icon(Icons.settings), label: l10n.settings),
    ];

    return Scaffold(
      appBar: switch (DesignPolicy.chooseNavigationLayout(context)) {
        // TODO(b150005): AppBar のグローバルな状態管理
        NavigationLayout.bar => AppBar(),
        _ => null,
      },
      body: SafeArea(
        // FIXME: Focus Traversal で非表示中のタブ(Branch)のウィジェットが traversable である問題
        child: switch (DesignPolicy.chooseNavigationLayout(context)) {
          NavigationLayout.bar => _navigationShell,
          NavigationLayout.rail => Row(
            children: [
              NavigationRail(
                destinations: destinations
                    .map(
                      (destination) => NavigationRailDestination(
                        icon: destination.icon,
                        label: Text(destination.label),
                      ),
                    )
                    .toList(),
                selectedIndex: _navigationShell.currentIndex,
                onDestinationSelected: (index) => _navigationShell.goBranch(
                  index,
                  initialLocation: index == _navigationShell.currentIndex,
                ),
                labelType: NavigationRailLabelType.all,
              ),
              const VerticalDivider(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: Spacing.xs.dp),
                  child: _navigationShell,
                ),
              ),
            ],
          ),
        },
      ),
      bottomNavigationBar:
          DesignPolicy.chooseNavigationLayout(context) == NavigationLayout.bar
          ? NavigationBar(
              selectedIndex: _navigationShell.currentIndex,
              destinations: destinations
                  .map(
                    (destination) => NavigationDestination(
                      icon: destination.icon,
                      label: destination.label,
                    ),
                  )
                  .toList(),
              onDestinationSelected: (index) => _navigationShell.goBranch(
                index,
                initialLocation: index == _navigationShell.currentIndex,
              ),
            )
          : null,
    );
  }
}
