import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide ScaffoldMessenger;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/firebase/auth/auth_repository.dart';
import '../../ui/core/ui/adaptive_scaffold.dart';
import '../../ui/core/ui/utils/scaffold_messenger.dart';
import '../../ui/sample/firebase/login/widgets/login_form.dart';
import '../../ui/sample/widgets/grid_view_settings_expansion_tile.dart';
import '../../ui/sample/widgets/sample_content_card.dart';
import '../config/constants/assets.dart';
import '../config/constants/sizes.dart';
import '../config/constants/widget_keys.dart';
import '../config/l10n/app_localizations.dart' as l10n;
import '../utils/l10n/app_localizations.dart';
import '../utils/logging/go_router_observer.dart';
import '../utils/riverpod/provider_change_notifier.dart';

part 'router.g.dart';
part 'routes/main_stateful_shell_route_data.dart';
part '../../ui/home/widgets/home_screen.dart';
part '../../ui/sample/widgets/sample_screen.dart';
part '../../ui/sample/firebase/widgets/firebase_screen.dart';
part '../../ui/settings/widgets/settings_screen.dart';
part '../../ui/sample/firebase/login/widgets/login_screen.dart';

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
    redirect: (_, state) => _redirect(state: state, ref: ref),
    refreshListenable: ProviderChangeNotifier(
      ref: ref,
      provider: authRepositoryProvider,
    ),
    initialLocation: HomeScreenRoute.path,
    observers: [GoRouterObserver()],
    // TODO(b150005): GoRouterObserver が完成したら有効化する
    // debugLogDiagnostics: kDebugMode,
    navigatorKey: rootNavigatorKey,
  );

  FutureOr<String?> _redirect({
    required GoRouterState state,
    required Ref ref,
  }) {
    final uri = state.uri;
    final isLoggedIn = ref.watch(currentUserProvider) != null;

    if (_requiresAuth(uri) && !isLoggedIn) {
      return LoginScreenRoute.absolutePath;
    }

    if (uri.path == LoginScreenRoute.absolutePath) {
      return FirebaseScreenRoute.absolutePath;
    }

    return null;
  }

  bool _requiresAuth(Uri uri) {
    const authRequiredPaths = [FirebaseScreenRoute.absolutePath];

    return authRequiredPaths.any(
      (authRequiredPath) => uri.path.startsWith(authRequiredPath),
    );
  }
}
