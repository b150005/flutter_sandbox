import 'package:flutter/material.dart';

extension TextSelectionExtension on TextSelection {
  bool contains(int offset) => start <= offset && offset < end;

  bool selectsAll(int length) => start == 0 && end == length;

  bool get singleSelected => (baseOffset - extentOffset).abs() == 1;
  bool get multipleSelected => (baseOffset - extentOffset).abs() > 1;
}
