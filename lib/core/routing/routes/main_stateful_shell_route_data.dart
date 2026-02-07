part of '../router.dart';

@TypedStatefulShellRoute<MainStatefulShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeStatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeScreenRoute>(
          path: HomeScreenRoute.path,
          name: HomeScreenRoute.absolutePath,
        ),
      ],
    ),
    TypedStatefulShellBranch<SampleStatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SampleScreenRoute>(
          path: SampleScreenRoute.path,
          name: SampleScreenRoute.absolutePath,
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<FirebaseScreenRoute>(
              path: FirebaseScreenRoute.path,
              name: FirebaseScreenRoute.absolutePath,
              routes: <TypedRoute<RouteData>>[
                TypedGoRoute<SignInScreenRoute>(
                  path: SignInScreenRoute.path,
                  name: SignInScreenRoute.absolutePath,
                ),
                TypedGoRoute<ForgotPasswordScreenRoute>(
                  path: ForgotPasswordScreenRoute.path,
                  name: ForgotPasswordScreenRoute.absolutePath,
                ),
                TypedGoRoute<SignUpScreenRoute>(
                  path: SignUpScreenRoute.path,
                  name: SignUpScreenRoute.absolutePath,
                  routes: <TypedRoute<RouteData>>[
                    TypedGoRoute<EmailSentScreenRoute>(
                      path: EmailSentScreenRoute.path,
                      name: EmailSentScreenRoute.absolutePath,
                    ),
                    TypedGoRoute<VerifyEmailScreenRoute>(
                      path: VerifyEmailScreenRoute.path,
                      name: VerifyEmailScreenRoute.absolutePath,
                    ),
                  ],
                ),
                TypedGoRoute<FirebaseAuthScreenRoute>(
                  path: FirebaseAuthScreenRoute.path,
                  name: FirebaseAuthScreenRoute.absolutePath,
                ),
                TypedGoRoute<DataConnectScreenRoute>(
                  path: DataConnectScreenRoute.path,
                  name: DataConnectScreenRoute.absolutePath,
                ),
              ],
            ),
            TypedGoRoute<LocalStorageScreenRoute>(
              path: LocalStorageScreenRoute.path,
              name: LocalStorageScreenRoute.absolutePath,
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingsStatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsScreenRoute>(
          path: SettingsScreenRoute.path,
          name: SettingsScreenRoute.absolutePath,
        ),
      ],
    ),
  ],
)
class MainStatefulShellRouteData extends StatefulShellRouteData {
  static final GlobalKey<NavigatorState> $navigatorKey =
      GlobalKey<NavigatorState>(
        debugLabel: 'StatefulShellRoute Navigator',
      );

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
