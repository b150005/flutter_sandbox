import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/build_context.dart';
import '../../providers/app_bar_state_provider.dart';

@immutable
class AppBarScope extends ConsumerStatefulWidget {
  const AppBarScope({super.key, this.state, required this.child});

  final AppBarState? state;
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBarScopeState();
}

class _AppBarScopeState extends ConsumerState<AppBarScope> {
  PageRoute<dynamic>? _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final modalRoute = context.modalRoute;
    if (modalRoute is PageRoute<dynamic>) {
      _route = modalRoute;
    }

    _syncAppBarState();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  void _syncAppBarState() {
    Future.microtask(() {
      if (!mounted || _route?.settings.name != context.currentPath) {
        return;
      }

      final appBarStateProviderNotifier = ref.read(
        appBarStateProvider.notifier,
      );
      final appBarState = widget.state;

      if (appBarState != null) {
        appBarStateProviderNotifier.update(appBarState);
        return;
      }

      appBarStateProviderNotifier.clear();
    });
  }
}
