import 'package:flutter/material.dart';

enum WindowSize {
  min(size: Size(320, 480));

  const WindowSize({required this.size});

  final Size size;
  double get width => size.width;
  double get height => size.height;
}

/// @see [Everything you should know about 8 point grid system in UX design](https://uxplanet.org/everything-you-should-know-about-8-point-grid-system-in-ux-design-b69cb945b18d)
enum IconSize {
  xxs(dp: 24),
  xs(dp: 32),
  sm(dp: 40),
  md(dp: 48),
  lg(dp: 56),
  xl(dp: 64),
  xxl(dp: 72),
  xxxl(dp: 80);

  const IconSize({required this.dp});

  final double dp;

  double get iconSize {
    final baseSize = dp * 0.5;
    return (baseSize / 8).round() * 8.0;
  }

  double get borderRadius {
    final baseRadius = dp * 0.25;
    return (baseRadius / 4).round() * 4.0;
  }

  double get blurRadius {
    final baseBlur = dp * 0.25;
    return (baseBlur / 4).round() * 4.0;
  }
}

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
