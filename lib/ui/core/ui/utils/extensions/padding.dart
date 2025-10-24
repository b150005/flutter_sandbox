import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget paddingAll(double value) => Padding(
    padding: EdgeInsetsGeometry.all(value),
    child: this,
  );

  Widget paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) =>
      Padding(
        padding: EdgeInsetsGeometry.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: this,
      );
}
