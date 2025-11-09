import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/providers/firebase_contents_provider.dart';
import '../../data/providers/sample_contents_provider.dart';
import '../../data/repositories/firebase/auth/auth_repository.dart';
import '../../data/repositories/shared_preferences/shared_preferences_repository.dart';
import '../../ui/core/extensions/build_context.dart';
import '../../ui/core/hooks/use_app_bar.dart';
import '../../ui/core/providers/app_bar_state_provider.dart';
import '../../ui/core/ui/auth/email_input_form.dart';
import '../../ui/core/ui/auth/password_setup_form.dart';
import '../../ui/core/ui/auth/sign_out_button.dart';
import '../../ui/core/ui/callout.dart';
import '../../ui/core/ui/dismiss_material_banner_button.dart';
import '../../ui/core/ui/layouts/adaptive_scaffold.dart';
import '../../ui/core/ui/layouts/scrollable_container.dart';
import '../../ui/core/ui/utils/app_messenger.dart';
import '../../ui/sample/firebase/auth/widgets/user_auth_detail_card.dart';
import '../../ui/sample/firebase/auth/widgets/user_profile_card.dart';
import '../../ui/sample/firebase/sign-in/widgets/sign_in_form.dart';
import '../../ui/sample/firebase/signup/widgets/sign_up_form.dart';
import '../../ui/sample/widgets/content_card.dart';
import '../config/constants/assets.dart';
import '../config/constants/button_size.dart';
import '../config/constants/grid_dimensions.dart';
import '../config/constants/icon_size.dart';
import '../config/constants/spacing.dart';
import '../config/constants/widget_keys.dart';
import '../utils/exceptions/app_exception.dart';
import '../utils/extensions/bool.dart';
import '../utils/extensions/nullable.dart';
import '../utils/l10n/app_localizations.dart';
import '../utils/logging/route_logging_observer.dart';
import '../utils/riverpod/provider_change_notifier.dart';

part '../../ui/home/widgets/home_screen.dart';
part '../../ui/sample/firebase/auth/widgets/firebase_auth_screen.dart';
part '../../ui/sample/firebase/data-connect/widgets/data_connect_screen.dart';
part '../../ui/sample/firebase/forgot-password/widgets/forgot_password_screen.dart';
part '../../ui/sample/firebase/sign-in/widgets/sign_in_screen.dart';
part '../../ui/sample/firebase/signup/email-sent/widgets/email_sent_screen.dart';
part '../../ui/sample/firebase/signup/verify-email/widgets/verify_email_screen.dart';
part '../../ui/sample/firebase/signup/widgets/sign_up_screen.dart';
part '../../ui/sample/firebase/widgets/firebase_screen.dart';
part '../../ui/sample/local-storage/widgets/local_storage_screen.dart';
part '../../ui/sample/widgets/sample_screen.dart';
part '../../ui/settings/widgets/settings_screen.dart';
part 'router.g.dart';
part 'routes/main_stateful_shell_route_data.dart';

@Riverpod(keepAlive: true)
class Router extends _$Router {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'GoRouter Navigator',
  );

  @override
  GoRouter build() => GoRouter(
    routes: $appRoutes,
    redirect: (_, state) {
      ref.read(appBarStateProvider.notifier).clear();

      return _redirect(state: state, ref: ref);
    },
    refreshListenable: ProviderChangeNotifier(
      ref: ref,
      provider: authRepositoryProvider,
    ),
    initialLocation: HomeScreenRoute.path,
    observers: [RouteLoggingObserver()],
    debugLogDiagnostics: kDebugMode,
    navigatorKey: rootNavigatorKey,
  );

  static FutureOr<String?> _redirect({
    required GoRouterState state,
    required Ref ref,
  }) {
    final uri = state.uri;

    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final isLoggedIn = firebaseAuth.currentUser != null;

    if (_requiresAuth(uri) && !isLoggedIn) {
      return SignInScreenRoute.absolutePath;
    }

    if (uri.path == SignInScreenRoute.absolutePath && isLoggedIn) {
      return FirebaseScreenRoute.absolutePath;
    }

    return null;
  }

  static bool _requiresAuth(Uri uri) {
    const authExcludedPaths = [
      SignInScreenRoute.absolutePath,
      ForgotPasswordScreenRoute.absolutePath,
      SignUpScreenRoute.absolutePath,
      EmailSentScreenRoute.absolutePath,
      VerifyEmailScreenRoute.absolutePath,
    ];

    return uri.path.startsWith(FirebaseScreenRoute.absolutePath) &&
        !authExcludedPaths.any(
          (authExcludedPath) => uri.path == authExcludedPath,
        );
  }
}
