import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/policy/design.dart';
import '../../../core/utils/l10n/app_localizations.dart';

class AdaptiveScaffold extends HookConsumerWidget {
  const AdaptiveScaffold({
    super.key,
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    return Scaffold(
      body: SafeArea(
        child: switch (DesignPolicy.chooseNavigationLayout(context)) {
          NavigationLayout.bar => _navigationShell,
          NavigationLayout.rail => Row(
            children: [
              NavigationRail(
                destinations: [
                  NavigationRailDestination(
                    icon: const Icon(Icons.home),
                    label: Text(l10n.home),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.science),
                    label: Text(l10n.sample),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.settings),
                    label: Text(l10n.settings),
                  ),
                ],
                selectedIndex: _navigationShell.currentIndex,
                onDestinationSelected: (index) => _navigationShell.goBranch(
                  index,
                  initialLocation: index == _navigationShell.currentIndex,
                ),
                labelType: NavigationRailLabelType.all,
              ),
              const VerticalDivider(),
              Expanded(child: _navigationShell),
            ],
          ),
        },
      ),
      bottomNavigationBar:
          DesignPolicy.chooseNavigationLayout(context) == NavigationLayout.bar
          ? NavigationBar(
              selectedIndex: _navigationShell.currentIndex,
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home),
                  label: l10n.home,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.science),
                  label: l10n.sample,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings),
                  label: l10n.settings,
                ),
              ],
              onDestinationSelected: (index) => _navigationShell.goBranch(
                index,
                initialLocation: index == _navigationShell.currentIndex,
              ),
            )
          : null,
    );
  }
}
