import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

extension TestFlutterViewExtension on TestFlutterView {
  Size get logicalSize => physicalSize / devicePixelRatio;
}
