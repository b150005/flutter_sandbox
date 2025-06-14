import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/nullable.dart';

final class ScaffoldMessenger {
  const ScaffoldMessenger._();

  static final key = GlobalKey<ScaffoldMessengerState>(
    debugLabel: 'ScaffoldMessenger',
  );

  static const _stateName = 'GlobalKey<ScaffoldMessengerState>.currentState';

  static void showSnackBar(
    String message, {
    SnackBarClosedReason reason = SnackBarClosedReason.hide,
    AnimationStyle? snackBarAnimationStyle,
  }) {
    key.currentState.ifNotNull((scaffoldMessangerState) {
      scaffoldMessangerState
        ..hideCurrentSnackBar(reason: reason)
        ..showSnackBar(
          SnackBar(content: Text(message)),
          snackBarAnimationStyle: snackBarAnimationStyle,
        );
    }, objectName: _stateName);
  }

  static void hideSnackBar({
    SnackBarClosedReason reason = SnackBarClosedReason.hide,
  }) {
    key.currentState.ifNotNull((scaffoldMessangerState) {
      scaffoldMessangerState.hideCurrentSnackBar(reason: reason);
    }, objectName: _stateName);
  }

  static void showMaterialBanner(
    MaterialBanner materialBanner, {
    MaterialBannerClosedReason reason = MaterialBannerClosedReason.hide,
  }) {
    key.currentState.ifNotNull((scaffoldMessangerState) {
      scaffoldMessangerState
        ..hideCurrentMaterialBanner(reason: reason)
        ..showMaterialBanner(materialBanner);
    }, objectName: _stateName);
  }

  static void hideMaterialBanner({
    MaterialBannerClosedReason reason = MaterialBannerClosedReason.hide,
  }) {
    key.currentState.ifNotNull((scaffoldMessangerState) {
      scaffoldMessangerState.hideCurrentMaterialBanner(reason: reason);
    }, objectName: _stateName);
  }
}
