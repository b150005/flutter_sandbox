part of '../router.dart';

@TypedStatefulShellRoute<MainStatefulShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeStatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeScreenRoute>(
          path: HomeScreenRoute.path,
          name: HomeScreenRoute.path,
        ),
      ],
    ),
    TypedStatefulShellBranch<SampleStatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SampleScreenRoute>(
          path: SampleScreenRoute.path,
          name: SampleScreenRoute.path,
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<FirebaseScreenRoute>(
              path: FirebaseScreenRoute.path,
              name: FirebaseScreenRoute.path,
              routes: <TypedRoute<RouteData>>[
                TypedGoRoute<LoginScreenRoute>(
                  path: LoginScreenRoute.path,
                  name: LoginScreenRoute.path,
                ),
                TypedGoRoute<SignUpScreenRoute>(
                  path: SignUpScreenRoute.path,
                  name: SignUpScreenRoute.path,
                  routes: <TypedRoute<RouteData>>[
                    TypedGoRoute<EmailSentScreenRoute>(
                      path: EmailSentScreenRoute.path,
                      name: EmailSentScreenRoute.path,
                    ),
                    TypedGoRoute<VerifyEmailScreenRoute>(
                      path: VerifyEmailScreenRoute.path,
                      name: VerifyEmailScreenRoute.path,
                    ),
                  ],
                ),
              ],
            ),
            TypedGoRoute<LocalStorageScreenRoute>(
              path: LocalStorageScreenRoute.path,
              name: LocalStorageScreenRoute.path,
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingsStatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsScreenRoute>(
          path: SettingsScreenRoute.path,
          name: SettingsScreenRoute.path,
        ),
      ],
    ),
  ],
)
class MainStatefulShellRouteData extends StatefulShellRouteData {
  static final GlobalKey<NavigatorState> $navigatorKey =
      Router.shellRouteNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) => AdaptiveScaffold(navigationShell: navigationShell);
}

class HomeStatefulShellBranchData extends StatefulShellBranchData {
  const HomeStatefulShellBranchData();
}

class SampleStatefulShellBranchData extends StatefulShellBranchData {
  const SampleStatefulShellBranchData();
}

class SettingsStatefulShellBranchData extends StatefulShellBranchData {
  const SettingsStatefulShellBranchData();
}
