import 'package:flutter/material.dart';

import 'logger.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // TODO(b150005): Firebase Analytics に送信
    // Logger.instance.logScreenView(
    //   route.settings.name,
    //   screenName,
    //   parameters,
    //   callOptions,
    // );

    Logger.instance.t(
      'Route pushed: ${previousRoute?.settings.name} => ${route.settings.name}',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Logger.instance.t(
      'Route popped: ${route.settings.name} => ${previousRoute?.settings.name}',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Logger.instance.t(
      'Route removed:'
      ' ${route.settings.name} => ${previousRoute?.settings.name}',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    Logger.instance.t(
      'Route replaced:'
      ' ${oldRoute?.settings.name} => ${newRoute?.settings.name}',
    );
  }

  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    Logger.instance.t(
      'Route top changed:'
      ' ${previousTopRoute?.settings.name} => ${topRoute.settings.name}',
    );
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    Logger.instance.t(
      'User gesture started:'
      ' ${previousRoute?.settings.name} => ${route.settings.name}',
    );
  }

  @override
  void didStopUserGesture() {
    Logger.instance.t('User gesture stopped');
  }
}
