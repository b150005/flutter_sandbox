import 'package:flutter/material.dart';

extension NavigatorStateExtension<T> on NavigatorState {
  bool safePop([T? result]) {
    if (canPop()) {
      pop(result);
      return true;
    }

    return false;
  }
}
