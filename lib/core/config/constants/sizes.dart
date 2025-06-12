import 'package:flutter/material.dart';

abstract final class Sizes {
  const Sizes._();

  static const WindowSizes window = WindowSizes.instance;
  static const UiSizes ui = UiSizes.instance;
}

final class WindowSizes {
  const WindowSizes._();

  static const instance = WindowSizes._();

  static const _minSize = Size(320, 480);
  Size get minSize => _minSize;
  double get minWidth => _minSize.width;
  double get minHeight => _minSize.height;
}

final class UiSizes {
  const UiSizes._();

  static const instance = UiSizes._();
}
