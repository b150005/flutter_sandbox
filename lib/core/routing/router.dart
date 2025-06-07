import 'package:flutter/material.dart' hide ScaffoldMessenger;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../ui/core/ui/adaptive_scaffold.dart';
import '../../ui/core/ui/utils/scaffold_messenger.dart';
import '../utils/logging/go_router_observer.dart';

part 'router.g.dart';
part 'routes/main_stateful_shell_route_data.dart';
part '../../ui/home/widgets/home_screen.dart';
part '../../ui/sample/widgets/sample_screen.dart';
part '../../ui/sample/firebase/widgets/firebase_screen.dart';
part '../../ui/settings/widgets/settings_screen.dart';

@Riverpod(keepAlive: true)
class Router extends _$Router {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'GoRouter Navigator',
  );

  static final shellRouteNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'StatefulShellRoute Navigator',
  );

  @override
  GoRouter build() => GoRouter(
    routes: $appRoutes,
    initialLocation: HomeScreenRoute.path,
    observers: [GoRouterObserver()],
    // TODO(b150005): GoRouterObserver が完成したら有効化する
    // debugLogDiagnostics: kDebugMode,
    navigatorKey: rootNavigatorKey,
  );
}
