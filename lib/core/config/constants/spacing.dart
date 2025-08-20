import 'package:flutter/material.dart';

enum Spacing {
  none(dp: 0),
  xxs(dp: 4),
  xs(dp: 8),
  sm(dp: 16),
  md(dp: 24),
  lg(dp: 32),
  xl(dp: 40),
  xxl(dp: 48),
  xxxl(dp: 56);

  const Spacing({required this.dp});

  final double dp;

  SizedBox get horizontal => SizedBox(width: dp);

  SizedBox get vertical => SizedBox(height: dp);
}
