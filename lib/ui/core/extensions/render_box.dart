import 'package:flutter/rendering.dart';

extension RenderBoxExtension on RenderBox {
  Rect get globalRect => localToGlobal(Offset.zero) & size;
}
